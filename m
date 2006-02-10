Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWBJQYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWBJQYh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWBJQYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:24:37 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:45864 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932140AbWBJQYg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:24:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=LTckXkzdE9cn2xJv8NxeBIsa0zRAuO/yqfTWnQc6rE2mtO4hYvixwr73hulZ8iQ4DJIjacv2eOQ6CAy8mwPNXirnc4nRmnTthGLV2ZMR5yFGDJGSNAslCiuAi0RDQ6LhOp3rRRsBmz3roGw/o5fkPC+FghbNqS8IK8Fu1AHknkY=
Date: Fri, 10 Feb 2006 17:24:28 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: tytso@mit.edu, schilling@fokus.fraunhofer.de, peter.read@gmail.com,
       mj@ucw.cz, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-Id: <20060210172428.6c857254.diegocg@gmail.com>
In-Reply-To: <43ECA934.nailJHD2NPUCH@burner>
References: <mj+md-20060209.173519.1949.atrey@ucw.cz>
	<43EC71FB.nailISD31LRCB@burner>
	<20060210114721.GB20093@merlin.emma.line.org>
	<43EC887B.nailISDGC9CP5@burner>
	<mj+md-20060210.123726.23341.atrey@ucw.cz>
	<43EC8E18.nailISDJTQDBG@burner>
	<Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr>
	<43EC93A2.nailJEB1AMIE6@burner>
	<20060210141651.GB18707@thunk.org>
	<43ECA3FC.nailJGC110XNX@burner>
	<20060210145238.GC18707@thunk.org>
	<43ECA934.nailJHD2NPUCH@burner>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 10 Feb 2006 15:54:44 +0100,
Joerg Schilling <schilling@fokus.fraunhofer.de> escribió:

> I am sorry, but it turns out that you did not understand the problem.


Could you explain why stat->st_dev / stat->st_ino POSIX semantics forces
POSIX implementations to have a stable stat->st_rdev number? 

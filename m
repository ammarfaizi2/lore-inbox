Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWCVFSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWCVFSz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 00:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWCVFSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 00:18:55 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:26854 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750779AbWCVFSy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 00:18:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Oh2JAOvuO+ojZedgov7tuPWUSxRUwV9wHZ1UXLYhThzTAijqH1NzU6MOZ+GOElIh9OOcjx3X1pyauvRUEoGz+n4IqdzGeilVVC77m1wne/3coS+7tag6rNdlAOpSXJ8lg2xYhnAMwsuwarqSXaDvvOwFPreE+Xa7ZbxHkxXHwgg=
Message-ID: <f4050c9e0603212118i35ee6defhdb53b72bc0dbb1d1@mail.gmail.com>
Date: Tue, 21 Mar 2006 22:18:53 -0700
From: "Andrew Shewmaker" <agshew@gmail.com>
To: "vamsi krishna" <vamsi.krishnak@gmail.com>
Subject: Re: Idea to create a elf executable from running program [process2executable]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3faf05680603181422y7447fd7duc1032bd0e07b9c68@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3faf05680603181422y7447fd7duc1032bd0e07b9c68@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/06, vamsi krishna <vamsi.krishnak@gmail.com> wrote:

> [PS: I dont know if some one has already implemented this idea??]

You might find it useful to look at BProc, specifically its Virtual Memory
Area Dumper.  It is used for process migration from a cluster's front
end node to its compute nodes.  I don't believe anyone has used it to
checkpoint a process.

http://bproc.sourceforge.net/c268.html#AEN279

Also, are you familiar with http://www.checkpointing.org ?

--
Andrew Shewmaker

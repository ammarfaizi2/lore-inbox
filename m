Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbUJ1Ogo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbUJ1Ogo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 10:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbUJ1Ogo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 10:36:44 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:50393 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261153AbUJ1Oev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 10:34:51 -0400
Date: Thu, 28 Oct 2004 16:34:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andreas Dilger <adilger@clusterfs.com>
cc: "Theodore Ts'o" <tytso@mit.edu>, Timo Sirainen <tss@iki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: readdir loses renamed files
In-Reply-To: <20041028114413.GL1343@schnapps.adilger.int>
Message-ID: <Pine.LNX.4.53.0410281633580.10272@yvahk01.tjqt.qr>
References: <431547F9-2624-11D9-8AC3-000393CC2E90@iki.fi> <20041025123722.GA5107@thunk.org>
 <20041028093426.GB15050@merlin.emma.line.org> <20041028114413.GL1343@schnapps.adilger.int>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I read over in reiserfs-list that the reason for the crazy renaming is
>to store "attributes" as part of the filename.  Why not just store them
>as EAs as they were intended?  With the large inode patches (posted here
>a couple of times already) the cost of storing EAs is negligible.

Well, reiser stores attributes (at least ACLs) in files.


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de

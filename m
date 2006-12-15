Return-Path: <linux-kernel-owner+w=401wt.eu-S1752109AbWLONJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbWLONJx (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 08:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107AbWLONJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 08:09:53 -0500
Received: from aeimail.aei.ca ([206.123.6.84]:63244 "EHLO aeimail.aei.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104AbWLONJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 08:09:52 -0500
X-Greylist: delayed 1193 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 08:09:51 EST
From: Ed Tomlinson <edt@aei.ca>
To: Nikolai Joukov <kolya@cs.sunysb.edu>
Subject: Re: [ANNOUNCE] RAIF: Redundant Array of Independent Filesystems
Date: Fri, 15 Dec 2006 07:47:02 -0500
User-Agent: KMail/1.9.5
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       unionfs@filer.fsl.cs.sunysb.edu, fistgen@filer.fsl.cs.sunysb.edu
References: <Pine.GSO.4.53.0612122217360.22195@compserv1>
In-Reply-To: <Pine.GSO.4.53.0612122217360.22195@compserv1>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612150747.02708.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 December 2006 12:47, Nikolai Joukov wrote:
> We have designed a new stackable file system that we called RAIF:
> Redundant Array of Independent Filesystems

Do you have a function similar to an an EMC cloneset?   Basicily a cloneset
tracks what has changed in both the source and target luns (drives).  When one
updates the cloneset the target is made identical to the source.  Its a great
way to do backups.  Its an important feature to be able to write to the target drives.
I would love to see this working at a filesystem level.

Thanks
Ed Tomlinson

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbWBMXhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbWBMXhF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbWBMXhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:37:05 -0500
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:31108 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030293AbWBMXhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:37:03 -0500
Message-ID: <43F1181D.1080202@bigpond.net.au>
Date: Tue, 14 Feb 2006 10:37:01 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Jean Delvare <khali@linux-fr.org>
Subject: Re: [ANNOUNCE] quilt 0.43
References: <7Ks06MZm.1139822040.2403500.khali@localhost>
In-Reply-To: <7Ks06MZm.1139822040.2403500.khali@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 13 Feb 2006 23:37:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:
> Hi all,
> 
> Quilt 0.43 has been released ten days ago (sorry for being slow). A
> number of improvements may be of interest to kernel developers so I am
> announcing it here on LKML.
> 
> Quilt 0.43 can be downloaded from here:
>   http://savannah.nongnu.org/download/quilt/quilt-0.43.tar.gz
> 
> Bug fixes:
>   Deleting the top patch works again,
>   patch delimiter ("---") is no more eaten on refresh.
> 
> Compatibility:
>   Huge efforts have been put into improving compatibility with many
>   platforms. The git specific patch format extensions are better
>   supported too.
> 
> New features:
>   The mail command has been completely reworked,
>   delete -r physically removes the deleted patch,
>   delete --backup makes a backup copy of the deleted patch,
>   annotate -P annotates a previous version of the file,
>   import can preserve or merge comments when updating a patch,
>   push detects reversed patches,
>   diffstat options can be specified,
>   patch delimiter ("---") is automatically inserted before diffstat.
> 

Changes to the interface in this version of quilt broke gquilt (a GUI 
wrapper for quilt) and if you use gquilt and upgrade to this version of 
quilt you will also need to upgrade to version 0.17 of gquilt.  It is 
available in source form at:

<http://users.bigpond.net.au/Peter-Williams/gquilt-0.17.tar.gz>

and rpm form at:

<http://users.bigpond.net.au/Peter-Williams/gquilt-0.17-1.noarch.rpm>

Enjoy,
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

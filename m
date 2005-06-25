Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263359AbVFYHhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263359AbVFYHhZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 03:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbVFYHhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 03:37:25 -0400
Received: from main.gmane.org ([80.91.229.2]:57767 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S263359AbVFYHhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 03:37:14 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jesper Krogh <jesper@krogh.cc>
Subject: Re: reiser4 plugins
Followup-To: gmane.linux.kernel
Date: Sat, 25 Jun 2005 05:26:36 +0000 (UTC)
Message-ID: <d9ipuc$gu$1@sea.gmane.org>
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl> <42BB31E9.50805@slaphack.com> <1119570225.18655.75.camel@localhost.localdomain> <42BB7B32.4010100@slaphack.com> <1119612849.17063.105.camel@localhost.localdomain> <42BCCC32.1090802@slaphack.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: linuxnews.dk
User-Agent: slrn/0.9.8.1 (Debian)
Cc: reiserfs-list@namesys.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

["Followup-To:" header set to gmane.linux.kernel.]
I gmane.linux.kernel, skrev David Masover:
> > Most desktop users today don't have backups because there is no credible
> > backup technology for 500Gb of data. They may have partial backups. Some
> 
>  Bandwidth is getting faster.  And I just found a nice site for backups
>  called streamload.com.  They don't seem to support rsync, and allow only
>  100 meg downloads, but unlimited uploads.
> 
>  Few desktop users today really need to backup more than 50 megs of data.

That gives tedious manual work.. and btw, won't save you if you from
loosing stuff from when the backup was made until now. 

> > things the fs can't deal with - if the disk goes boom then thats a lower
> > level concern. Also certain bits like writing to spare blocks on a
> > problem write are indeed handled drive level nowdays.
> 
>  Right.  And putting them in the FS is unneccesary bloat if you've got
>  another mechanism for dealing with it.  Anyone with 500 gigs of data can
>  afford to do a little RAID, or at least some burned DVDs.
> 
>  DVDs are cheap nowdays:
>  http://www.newegg.com/Product/Product.asp?Item=N82E16817502002

Again lots of manual work.. I actually have a DAT-station.. but I'm not
getting it used. People have DVD-burners, but many don't get time to do
a backup anyway. A Copy-On-Write feature in the filesystem would save
the average dataloss situation todag (for home users). Where they
accidentally deletes stuff. 

>  Streamload.

Why, when it could be quick and transparent. And Linux is used many
places where you cant let data out-of-the-house of where bandwidth
"sucks". The waste-space in my diskdrives increases everyday .. and i
fill up with a tar-ball of the system every now-and-then, but it would
definately be better suited and more effecient (save me more times) done
directly in the filesystem. 

>  I agree it's nice to have a more corruption-proof filesystem.
>  Convenient.  But not absolutely necessary.

Thats called raid, we have that allready. But raid won't help for and: 
rm /etc/passwd, a Copy-On-Write filesystem (not-snapshot) would. Used on
a mirrored raiddisk, with enough space on the disk, it would actually
guard you from allmost anything but getting the computer stolen. 

Totally unrelated to reiser4 but a feature that would be nice to have in
"any" filesystem. 

Jesper
-- 
./Jesper Krogh, jesper@krogh.cc



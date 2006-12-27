Return-Path: <linux-kernel-owner+w=401wt.eu-S932895AbWL0DmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932895AbWL0DmN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 22:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932897AbWL0DmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 22:42:13 -0500
Received: from ag-out-0708.google.com ([72.14.246.242]:31108 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932895AbWL0DmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 22:42:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=Q6Nit5yz1fbPUG25UmNkTaPupgYSbhdm1pAsO4zu90Scmsjd8KABHl0HIpgdLaCRBlwYxwu6INoQLmW9FehLbdAFRvhoz1/8KWvpwFeK9+QBlEcgMKjGd80TaC8XsCHaK3u9qd95YTdU3zm3xYoLCaMbusy4/XruHc9ZCjO2u7Q=
Message-ID: <4591EB76.3060801@gmail.com>
Date: Wed, 27 Dec 2006 12:41:42 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: erik@echohome.org
CC: linux-kernel@vger.kernel.org
Subject: Re: System / libata IDE controller woes (long)
References: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAAJ1ef91k2DRKvSshkps/AYkBAAAAAA==@echohome.org>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAAJ1ef91k2DRKvSshkps/AYkBAAAAAA==@echohome.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Erik Ohrnberger wrote:
> Earlier this year, when I started putting it together, I gathered my
> hardware.  A decent 2 GHz Athlon system with 512 MB RAM, DVD drive, a 40 GB
> system drive, and a 500 Watt power supply.  Then I started adding hard
> disks.  To date, I've got 5 80 GB PATA, 2 200 GB PATA, and 1 60 GB PATA.

That's 9 hard drives.  How did you hook up your power supply?  My
dual-rail 450w PS has a lot of problem driving 9 drives no matter how I
hook it up while my 350w power supply can happily handle the load.  I
suspect it's because how the separate 12v rails are configured in the PS.

It's nothing concrete but I wanna rule PS issue first.  If you've got an
extra power supply (buy cheap 350w one if you don't have one), hook half
of the drives to it and see what happens.  Using PS without motherboard
is easy.  Just ask google.

Happy holidays.

-- 
tejun

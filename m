Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWAYRLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWAYRLp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 12:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWAYRLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 12:11:45 -0500
Received: from mail.gmx.net ([213.165.64.21]:21683 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932076AbWAYRLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 12:11:44 -0500
X-Authenticated: #428038
Message-ID: <43D7B14D.7040802@gmx.de>
Date: Wed, 25 Jan 2006 18:11:41 +0100
From: Matthias Andree <matthias.andree@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: jengelh@linux01.gwdg.de, axboe@suse.de, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr> <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>
In-Reply-To: <43D7AF56.nailDFJ882IWI@burner>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> Jens Axboe <axboe@suse.de> wrote:
> 
>> You just want the device naming to reflect that. The user should not
>> need to use /dev/hda, but /dev/cdrecorder or whatever. A real user would
>> likely be using k3b or something graphical though, and just click on his
>> Hitachi/Plextor/whatever burner. Perhaps some fancy udev rules could
>> help do this dynamically even.
> 
> Guess why cdrecord -scanbus is needed.
> 
> It serves the need of GUI programs for cdrercord and allows them to retrieve 
> and list possible drives of interest in a platform independent way.

There are bugs in the implementation that prevent -scanbus from working
properly, and they are not Linux bugs. Once -scanbus really scans all
devices and skips those it cannot access (rather than quitting), you might
have a point.

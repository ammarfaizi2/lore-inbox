Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbWGERTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWGERTS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 13:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbWGERTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 13:19:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:39180 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964921AbWGERTR (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 13:19:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lAcbolD2uukkHrdrAOep0L6jHT2jTmQ8m+u4Iqd6Lf5vKwsnfMFTHbnasJlZUuCsZJPEaDNpi/lkZco0c7tYstWMWwouggrLdl/LCo+fQH4aDYXu+zzH8zK40F37lXrmI6tl5ewKo5ZZEOMX/ucMWW2ptUz3wDXySKhBPvnIxAw=
Message-ID: <dda83e780607051019q4bcdf4e2w346634441cba492@mail.gmail.com>
Date: Wed, 5 Jul 2006 10:19:16 -0700
From: "Bret Towe" <magnade@gmail.com>
To: "Nikita Danilov" <nikita@clusterfs.com>
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh entirely
Cc: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
       "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
In-Reply-To: <17579.37504.509233.959683@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <B41635854730A14CA71C92B36EC22AAC06CCF2@mssmsx411>
	 <17578.52643.364026.64265@gargle.gargle.HOWL>
	 <dda83e780607041524g5ae996fes6e579464a1af56ad@mail.gmail.com>
	 <17579.37504.509233.959683@gargle.gargle.HOWL>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/06, Nikita Danilov <nikita@clusterfs.com> wrote:
> Bret Towe writes:
>
> [...]
>
>  >
>  > are you sure about that? cause that sounded alot like an issue
>  > i saw with slow usb devices (mainly a usb hd on a usb 1.1 connection)
>  > the usb device would fill up with write queue and local io to say /dev/hda
>  > would basicly stop and the system would be rather useless till the usb
>  > hd would finish writing out what it was doing
>  > usally would take several hundred megs of data to get it to do it
>
> There may be bazillion other reasons for slow device making system
> unresponsive in various ways. More details are needed (possibly in
> separate thread).

well at this time all i know is one will be writing to the usb hd its queue
will fill up and if say some gtk app wants to write to disk it will freeze
until the usb hd is completely done
i will look into it at some point when i have time and get more info on
it and post a proper report on the issue unless its already been fixed

>  >
>  > ive not tried it in ages so maybe its been fixed since ive last tried it
>  > dont recall the kernel version at the time but it wasnt more than a
>  > year ago
>  >
>
> Nikita.
>

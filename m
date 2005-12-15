Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbVLOD62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbVLOD62 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 22:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbVLOD62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 22:58:28 -0500
Received: from smtpout.mac.com ([17.250.248.84]:33494 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1030358AbVLOD61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 22:58:27 -0500
In-Reply-To: <Pine.LNX.4.61.0512091523520.8080@yvahk01.tjqt.qr>
References: <20051129002801.GA9785@mipter.zuzino.mipt.ru> <D6440692-33C3-45F0-9112-C22332ED7072@bootc.net> <20051129013354.GA17749@mipter.zuzino.mipt.ru> <20051129054819.GR11266@alpha.home.local> <20051130102111.GK9949@vanheusden.com> <20051130212350.GV11266@alpha.home.local> <Pine.LNX.4.61.0512091523520.8080@yvahk01.tjqt.qr>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E7365ED3-3761-430C-A11A-2E7AB898BAF9@mac.com>
Cc: Willy Tarreau <willy@w.ods.org>,
       Folkert van Heusden <folkert@vanheusden.com>,
       Alexey Dobriyan <adobriyan@gmail.com>, Chris Boot <bootc@bootc.net>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] un petite hack: /proc/*/ctl
Date: Wed, 14 Dec 2005 22:58:06 -0500
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 09, 2005, at 09:24, Jan Engelhardt wrote:
>> not at all. It's just that patches on the list take more and more  
>> time to check, we're around something like 1 patch for 5 mails.  
>> And when the author himself suggests that the patch is not for  
>> inclusion, it wastes time. However, I agree that Alexey announced  
>> it as [RFC] and not [PATCH],
>
> Such things should be tagged as [OT] then, they are not worth  
> enough to be named [RFC].

Just thinking about this a bit more, this does have some practical  
value.  This would allow a process to acquire a "PID handle", such  
that it could later reliably send a signal to this process without  
worrying about any of the traditional PID reuse issues.  This would  
also solve some of the problems of the process checkpointing people.

Cheers,
Kyle Moffett

--
Simple things should be simple and complex things should be possible
   -- Alan Kay




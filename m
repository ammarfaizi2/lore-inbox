Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbVCBKMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVCBKMd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 05:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVCBKMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 05:12:33 -0500
Received: from smtp1.pochta.ru ([81.211.64.6]:11302 "EHLO smtp1.pochta.ru")
	by vger.kernel.org with ESMTP id S262258AbVCBKMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 05:12:24 -0500
X-Author: vlnb@front.ru from vlnb.net (asplinux.ru [195.133.213.194]) via Free Mail POCHTA.RU
Message-ID: <4225922D.7050305@vlnb.net>
Date: Wed, 02 Mar 2005 13:15:09 +0300
From: Vladislav Bolkhovitin <vst@vlnb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Nauman <mailtonauman@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SCSI Target Mode issue...... pls help
References: <3cac075b050301230046289a03@mail.gmail.com>
In-Reply-To: <3cac075b050301230046289a03@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check SCSI target mid-level (SCST) with Qlogic target driver on 
http://scst.sourceforge.net.

Best regards,
Vlad

Nauman wrote:
> hello all the gurus out there, 
> i have written simple Target for SCSI device. its in very early stage.
> I started to handle simple commands from the INITIATOR like INQUIRY,
> READ CAPACITY , REPORT LUN.
> Now i am upto READ and WRITE. I have responded READ properly. Problem
> is in WRITE command. For instance there is a case when i get multiple
> WRITE command from INITIATOR
> i queue command as i receive it. CTIO has to be sent to firmware for
> each recieved command  . in my case i send CTIO as i recieve the
> command. now firmware has to send back the response for each CTIO i
> sent. here is whats happening
> i get 2 commands for WRITE. send CTIO for cmd1 and cmd2 and what i get
> back from firmware is response of second cmd which is cmd2. cmd1's
> command time out occurs and it fails to respond.
> 
> if any one has done basic handshake and handled READ and WRITE for
> TARGET mode then please share ur knowledge......
> Best Regards,


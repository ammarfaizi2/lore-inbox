Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317068AbSHTSpU>; Tue, 20 Aug 2002 14:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317102AbSHTSpT>; Tue, 20 Aug 2002 14:45:19 -0400
Received: from mail.gmx.de ([213.165.64.20]:65461 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317068AbSHTSpT>;
	Tue, 20 Aug 2002 14:45:19 -0400
Message-ID: <3D628F90.6040301@gmx.net>
Date: Tue, 20 Aug 2002 20:50:56 +0200
From: Gunther Mayer <gunther.mayer@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18-rc3aa3: dma_intr: status=0x51 errors
References: <Pine.LNX.4.10.10208181304310.23171-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:

>Because it is a hardware error.
>Your drive is attempting to reallocate sectors and is failing.
>
The drive cannot relocate on an "uncorrectable read error",
as this must be communicated to the user, so he can get
the data from backup.




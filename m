Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314475AbSFXRb0>; Mon, 24 Jun 2002 13:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314485AbSFXRbZ>; Mon, 24 Jun 2002 13:31:25 -0400
Received: from nwd2mime2.analog.com ([137.71.25.114]:16652 "EHLO
	nwd2mime2.analog.com") by vger.kernel.org with ESMTP
	id <S314475AbSFXRbY>; Mon, 24 Jun 2002 13:31:24 -0400
Message-ID: <3D175764.48E562F7@analog.com>
Date: Mon, 24 Jun 2002 10:31:16 -0700
From: Justin Wojdacki <justin.wojdacki@analog.com>
Reply-To: justin.wojdacki@analog.com
Organization: Analog Devices, Communications Processors Group
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Domcan Sami <domca_psg@email.com>
CC: linux-mips@oss.sgi.com, linux-kernel@vger.kernel.org,
       redhat-list@redhat.com
Subject: Re: Linux Boot sequence on MIPS??
References: <20020622093321.25583.qmail@email.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Domcan Sami wrote:
> 
> Hello everybody
>  I m trying to develop a Linux boot-loader for MIPS processor, can
> anybody help me sending the Linux boot sequence on MIPS. Any sites for
> reference? Thanks
> 

Where do you expect to load the kernel from? And what CPU/Board? 

The basic process is to POST the board, load the kernel into SDRAM,
and run the kernel. Where you want to load the kernel from determines
the other initialization work you need to do. 

Alternately, have you looked at PMON? It may provide everything you
need for a MIPS-based system. 

-- 
-------------------------------------------------
Justin Wojdacki        
justin.wojdacki@analog.com         (408) 350-5032
Communications Processors Group -- Analog Devices

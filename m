Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264856AbSJOR2i>; Tue, 15 Oct 2002 13:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbSJOR2i>; Tue, 15 Oct 2002 13:28:38 -0400
Received: from franka.aracnet.com ([216.99.193.44]:31197 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264856AbSJOR2h>; Tue, 15 Oct 2002 13:28:37 -0400
Date: Tue, 15 Oct 2002 10:32:19 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: James Bottomley <James.Bottomley@steeleye.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Summit support for 2.5 - now with subarch! [4/5] 
Message-ID: <2066506098.1034677937@[10.10.2.3]>
In-Reply-To: <200210151730.g9FHU4f03129@localhost.localdomain>
References: <200210151730.g9FHU4f03129@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> That's pretty pointless for one variable. I think you're taking things
>> to ridiculous extremes.
> 
> OK, I agree that a single .c file for one variable is very extreme.  I think 
> you also would agree with me that if it had been ten variables and an exported 
> function then it should live in a separate .c file in the summit specific code.

Yup.
 
> If you can promise me that summit will never need an extra variable or 
> exported function as the code evolves from now until the end of the 
> architecture then I can live with summit_x86 in the main line.

I don't think it'll ever need it, but if it does, I'll create it ;-)

M.


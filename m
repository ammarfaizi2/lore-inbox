Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266430AbRGCDDc>; Mon, 2 Jul 2001 23:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266432AbRGCDDW>; Mon, 2 Jul 2001 23:03:22 -0400
Received: from dsl081-080-099.lax1.dsl.speakeasy.net ([64.81.80.99]:12028 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id <S266430AbRGCDDF>; Mon, 2 Jul 2001 23:03:05 -0400
To: <newton@ns.kias.re.kr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Q] IP Autoconfiguration problem..???
In-Reply-To: <Pine.GSO.3.96K.1010703114612.10699A-100000@ns.kias.re.kr>
X-Shopping-List: (1) Biochemical eggplant coolants
   (2) Pelvic egg flakes
   (3) Perfidious suicides
From: "Bryan O'Sullivan" <bos@serpentine.com>
Date: 02 Jul 2001 20:02:51 -0700
In-Reply-To: <Pine.GSO.3.96K.1010703114612.10699A-100000@ns.kias.re.kr>
Message-ID: <873d8e4sv8.fsf@pelerin.serpentine.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Academic Rigor)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

n> I use kernel 2.4.5 with IP Autoconfiguration included dhcp, bootp,
n> rarp .

n> but, This kernel has not request IP to my dhcp server.  so, kernel
n> panic...

The default behaviour changed in 2.4.4-pre8.  You have to add ip=dhcp
or ip=bootp to the kernel command line in order for the kernel to
actually use autoconfiguration.

        <b

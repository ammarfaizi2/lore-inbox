Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269447AbTCDSC2>; Tue, 4 Mar 2003 13:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269454AbTCDSC2>; Tue, 4 Mar 2003 13:02:28 -0500
Received: from franka.aracnet.com ([216.99.193.44]:19386 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S269447AbTCDSCZ>; Tue, 4 Mar 2003 13:02:25 -0500
Date: Tue, 04 Mar 2003 10:12:52 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: ravikumar.chakaravarthy@amd.com, linux-kernel@vger.kernel.org
Subject: RE: Loading and executing kernel from a non-standard address usin g
 SY SLINUX
Message-ID: <127030000.1046801571@[10.10.2.4]>
In-Reply-To: <99F2150714F93F448942F9A9F112634CA54B08@txexmtae.amd.com>
References: <99F2150714F93F448942F9A9F112634CA54B08@txexmtae.amd.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes the kernel is uncompressed to the right location (0x200000), in my
> case. When I try to uncompress it to a non standard address (other than
> 0x100000), the address mapping is affected. 

Why would you need to uncompress it to a different address? You mention
that your bootloader does something odd, but that should only affect the
address of the compressed bzImage, not the decompressed kernel ...

M.


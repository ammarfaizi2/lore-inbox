Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVGUTF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVGUTF4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 15:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVGUTF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 15:05:56 -0400
Received: from [81.2.110.250] ([81.2.110.250]:19913 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261845AbVGUTFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 15:05:53 -0400
Subject: Re: often ide errors on amd64 / A8N-SLI
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050721172648.GA21124@amd64.of.nowhere>
References: <20050721172648.GA21124@amd64.of.nowhere>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 21 Jul 2005 20:30:13 +0100
Message-Id: <1121974214.19424.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-07-21 at 19:26 +0200, jurriaan wrote:
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }


There was corruption on the cable between the controller and drive. That
usually indicates a cable or noise problem in the PC but could indicate
mistuning of the interface. Make sure the IDE cable is 


 [controller]<---- long section ----->[slave]--short section-->[master]


as one common cause is having the cable the other way around.


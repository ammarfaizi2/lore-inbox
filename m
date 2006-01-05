Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWAEPS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWAEPS1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWAEPS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:18:27 -0500
Received: from mx.pathscale.com ([64.160.42.68]:28105 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751408AbWAEPS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:18:26 -0500
Subject: Re: [2.6 patch] Define BITS_PER_BYTE
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0601050802590.10161@yvahk01.tjqt.qr>
References: <20051108185349.6e86cec3.akpm@osdl.org>
	 <437226B1.4040901@cosmosbay.com> <20051109220742.067c5f3a.akpm@osdl.org>
	 <4373698F.9010608@cosmosbay.com> <43BB1178.7020409@cosmosbay.com>
	 <20060104034534.45d9c18a.akpm@osdl.org> <20060104232442.GX3831@stusta.de>
	 <Pine.LNX.4.61.0601050802590.10161@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 05 Jan 2006 07:18:21 -0800
Message-Id: <1136474301.31922.1.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 08:03 +0100, Jan Engelhardt wrote:

> Oh no :( This sounds as uncommon as CHAR_BIT in C.

CHAR_BIT is completely unclear.  BITS_PER_BYTE is self-evident, and
makes it a lot more obvious when you're doing arithmetic that involves
counting bits.

	<b


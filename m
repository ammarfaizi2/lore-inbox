Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161101AbVKYOUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101AbVKYOUh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 09:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161091AbVKYOUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 09:20:37 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:20133 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161081AbVKYOUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 09:20:36 -0500
Subject: Re: Assorted bugs in the PIIX drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1132929808.3298.18.camel@localhost.localdomain>
References: <1132929808.3298.18.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 25 Nov 2005 14:53:36 +0000
Message-Id: <1132930416.3298.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-11-25 at 14:43 +0000, Alan Cox wrote:
> I finally got all the documents rounded up to try and redo Jgarzik's
> PIIX driver a bit more completely (I'm short MPIIX if anyone has it ?)

Add another one - PPE is set unconditionally while the documentation
says it should be set for fixed disk only.


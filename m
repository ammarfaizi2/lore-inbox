Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935778AbWK1Ibj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935778AbWK1Ibj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 03:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935774AbWK1Ibj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 03:31:39 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:44673 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S935778AbWK1Ibj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 03:31:39 -0500
Message-ID: <456BF3E8.6060706@pobox.com>
Date: Tue, 28 Nov 2006 03:31:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] PATA libata: suspend/resume simple cases
References: <20061122165736.78e57d16@localhost.localdomain>
In-Reply-To: <20061122165736.78e57d16@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> This patch adds the suspend/resume callbacks for drivers which don't need
> any additional help (beyond the pci resume quirk patch I posted earlier
> anyway). Also bring version numbers back inline with master copies.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied this, and suspend/resume patches for

cmd64x
cs5520
cs5530
jmicron
rz1000
ali
sil680



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316935AbSGSUPw>; Fri, 19 Jul 2002 16:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317006AbSGSUPw>; Fri, 19 Jul 2002 16:15:52 -0400
Received: from server72.aitcom.net ([208.234.0.72]:26375 "EHLO test-area.com")
	by vger.kernel.org with ESMTP id <S316935AbSGSUPw>;
	Fri, 19 Jul 2002 16:15:52 -0400
Message-Id: <200207192018.QAA19141@test-area.com>
Content-Type: text/plain; charset=US-ASCII
From: anton wilson <anton.wilson@camotion.com>
To: J Sloan <jjs@lexus.com>
Subject: Re: 2.4 O(1) scheduler
Date: Fri, 19 Jul 2002 16:17:56 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <200207191943.PAA00351@test-area.com> <3D386E70.4040401@lexus.com>
In-Reply-To: <3D386E70.4040401@lexus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 July 2002 03:54 pm, J Sloan wrote:
> Use 2.4-aa, 2.4-ac or 2.4-redhat kernel
> and you get the O(1) secheduler at
> no extra cost -
>


> Joe


I'm actually worried not about just the O(1) scheduler but if these patches 
will be incorporating the O(1) bug fixes such as the serious one in 
balance_load where curr->next was used instead of current->prev. Also, I need 
to use a patch that won't tamper with the usb implementation because I'd have 
to update our current usb driver to fit into the new system, and I'm getting 
flack about wasting time trying to update that thing already . . . So if you 
tell me no, I can go tell my boss I have to update the usb driver.


Anton

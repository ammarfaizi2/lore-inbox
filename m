Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVEWEad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVEWEad (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 00:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVEWEad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 00:30:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44768 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261837AbVEWEa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 00:30:28 -0400
Date: Mon, 23 May 2005 00:30:15 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Reiner Sailer <sailer@us.ibm.com>
cc: Pavel Machek <pavel@ucw.cz>, <Toml@us.ibm.com>, <Emilyr@us.ibm.com>,
       <linux-kernel@vger.kernel.org>, <Kylene@us.ibm.com>,
       <linux-security-module@wirex.com>
Subject: Re: [PATCH 2 of 4] ima: related Makefile compile order change and
 Readme
In-Reply-To: <Pine.WNT.4.63.0505221821520.4896@laptop>
Message-ID: <Xine.LNX.4.44.0505230028380.29960-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 May 2005, Reiner Sailer wrote:

> IMA implements the measurment hooks and maintains the measurement list 
> and its integrity value in the TPM PCR. Services retrieving and evaluating 
> measurement lists can be based on top of IMA.

Perhaps I don't understand things fully, but what is the purpose of 
providing measurement values locally via proc?

How can they be trusted without the TPM signing an externally generated 
nonce?


- James
-- 
James Morris
<jmorris@redhat.com>



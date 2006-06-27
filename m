Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbWF0TWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbWF0TWj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030310AbWF0TWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:22:39 -0400
Received: from unn-206.superhosting.cz ([82.208.4.206]:57062 "EHLO
	mail.aiken.cz") by vger.kernel.org with ESMTP id S1030307AbWF0TWg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:22:36 -0400
Message-ID: <44A1858B.9080102@kernel-api.org>
Date: Tue, 27 Jun 2006 21:22:51 +0200
From: Lukas Jelinek <info@kernel-api.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; cs-CZ; rv:1.7.12) Gecko/20050915
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel API Reference Documentation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

a few months ago I looked for something like "Linux Kernel API Reference
Documentation". This search was unsuccessful and somebody recommended me
to generate this documentation from the kernel headers.

I have used Doxygen for this work. But the headers have needed to be
preprocessed by 'sed' using some regexp rules (due to various
incompatible comment formats).

Now I decide to share the result worldwide. The current generated
"Kernel API Reference" can be found at http://www.kernel-api.org.
Although it is very buggy this time I think it may be useful for module
developers.

To allow this work to be better, I suggest to establish some rules for
writing code comments (especially for function prototypes, data
structures etc.) and to add the comments to the kernel headers. The
rules should be chosen carefully to be well accepted by various
documentation generators (at least by Doxygen).

Thank you for your time dedicated to this idea.

Regards

Lukas Jelinek


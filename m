Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932751AbWEXPyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932751AbWEXPyo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 11:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932756AbWEXPyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 11:54:43 -0400
Received: from mpc-26.sohonet.co.uk ([193.203.82.251]:16786 "EHLO
	moving-picture.com") by vger.kernel.org with ESMTP id S932754AbWEXPyn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 11:54:43 -0400
Message-ID: <447481C0.5050709@moving-picture.com>
Date: Wed, 24 May 2006 16:54:40 +0100
From: James Pearson <james-p@moving-picture.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040524
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 4096 byte limit to /proc/PID/environ ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Disclaimer: This email and any attachments are confidential, may be legally
X-Disclaimer: privileged and intended solely for the use of addressee. If you
X-Disclaimer: are not the intended recipient of this message, any disclosure,
X-Disclaimer: copying, distribution or any action taken in reliance on it is
X-Disclaimer: strictly prohibited and may be unlawful. If you have received
X-Disclaimer: this message in error, please notify the sender and delete all
X-Disclaimer: copies from your system.
X-Disclaimer: 
X-Disclaimer: Email may be susceptible to data corruption, interception and
X-Disclaimer: unauthorised amendment, and we do not accept liability for any
X-Disclaimer: such corruption, interception or amendment or the consequences
X-Disclaimer: thereof.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that /proc/PID/environ only returns the first 4096 bytes of a 
processes' environment.

Is there any other way via userland to get the whole environment for a 
process?

Thanks

James Pearson


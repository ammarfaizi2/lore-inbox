Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWI0EBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWI0EBm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 00:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWI0EBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 00:01:42 -0400
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net ([70.91.206.233]:33685
	"EHLO saville.com") by vger.kernel.org with ESMTP id S932391AbWI0EBm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 00:01:42 -0400
Message-ID: <4519F7A9.4050807@saville.com>
Date: Tue, 26 Sep 2006 21:01:45 -0700
From: Wink Saville <wink@saville.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Zero copy between ISR, kernel and User
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to allow the transferring of data between ISR's, kernel and 
user code, without requiring copying. I envision allocating buffers in 
the kernel and then mapping them so that they appear at the same 
addresses to all code, and never being swapped out of memory.

Is this feasible for all supported Linux architectures and is there 
existing code that someone could point me towards?

Regards,

Wink Saville


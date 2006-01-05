Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751842AbWAEMU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbWAEMU6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 07:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752174AbWAEMU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 07:20:58 -0500
Received: from hermes.ciemat.es ([130.206.11.6]:4624 "EHLO hermes.ciemat.es")
	by vger.kernel.org with ESMTP id S1751842AbWAEMU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 07:20:57 -0500
Date: Thu, 05 Jan 2006 13:21:50 +0100
From: =?ISO-8859-1?Q?Jose_Gonz=E1lez?= <jose.gonzalez@psa.es>
Subject: socketpair - too many open files
To: linux-kernel@vger.kernel.org
Message-id: <43BD0F5E.6020108@psa.es>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: es-es, en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922
 Fedora/1.7.12-1.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
I am programming an application that need to create over 300 threads. 
Each thread calls socketpair function, but it returns EMFILE when it is 
called 150 times. Which kernel parameter can I change to do it?
Best regards,
Jose.

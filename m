Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVCEJlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVCEJlj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 04:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVCEJlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 04:41:39 -0500
Received: from office.icomedias.com ([62.99.232.80]:3989 "EHLO
	relay.icomedias.com") by vger.kernel.org with ESMTP id S261388AbVCEJlf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 04:41:35 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: ipmi in kernel 2.6.11
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Sat, 5 Mar 2005 10:41:31 +0100
Message-ID: <FA095C015271B64E99B197937712FD02510ACF@freedom.grz.icomedias.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ipmi in kernel 2.6.11
Thread-Index: AcUhZ4LM8GSip/5cQXG54EnLbIoPHw==
From: "Bene Martin" <martin.bene@icomedias.com>
To: <bunk@stusta.de>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

bmcsensors package (reading hardware sensors provided by intel boards
via ipmi) used to work fine with 2.6.10; no longer works with 2.6.11
because of removal of the ipmi_request function (+ exported symbol).

correct fix would be to use ipmi_request_settime with retries=-1 and
retry_time_ms=0?

Thanks, Martin

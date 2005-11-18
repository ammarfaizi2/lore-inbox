Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161023AbVKRKiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbVKRKiH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 05:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbVKRKiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 05:38:07 -0500
Received: from us01smtp1.synopsys.com ([198.182.44.79]:16624 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S1161023AbVKRKiF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 05:38:05 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Subject: Does Linux has File Stream mapping support...?
Date: Fri, 18 Nov 2005 16:08:00 +0530
Message-ID: <7EC22963812B4F40AE780CF2F140AFE920904A@IN01WEMBX1.internal.synopsys.com>
Thread-Topic: Does Linux has File Stream mapping support...?
Thread-Index: AcXsLCWMuKPq1JEnRAKN1DyQ7rQdyw==
From: "Arijit Das" <Arijit.Das@synopsys.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Nov 2005 10:38:04.0460 (UTC) FILETIME=[280D3EC0:01C5EC2C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to have File Stream Mapping in Linux? What I mean is
this...

FILE * fp1 = fopen("/foo", "w");
FILE * fp2 = fopen("/bar", "w");
FILE * fp_common = <Stream_Mapping_Func>(fp1, fp2);

fprint(fp_common, "This should be written to both files ... /foo and
/bar");

So, what I am looking for is anything written to "fp_common" should
actually be written to the streams fp1 and fp2.

Does Linux support this any way? Is there any way to achieve this...? Is
there anything like <Stream_Mapping_Func>(above) ...?

Do pardon me if you feel that it is a wrong Forum to ask this question
but I tried everywhere else and thought that implementers would best
know about it, if at all anything like that exists.

Thanks,
Arijit

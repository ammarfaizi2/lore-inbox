Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbWHNPnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWHNPnO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 11:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWHNPnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 11:43:14 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:23310 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751044AbWHNPnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 11:43:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Sopsy+UR2VxlJedUMc+ez9jwR0MhL+ywcKKNri4T3wAT9INS2VT9frn1sYARPxjt1QUMdYUEjTgFs6MDaXrOIC70LP8esRxFBFX/EfQ+KKl4bQKjv0+mdLxZHZWMdfaQE3AhuqEGOTG/onu98Lefi9PwPQqPD5FR02uhV1kD4b4=
Message-ID: <1b270aae0608140843s33918427vc1ab5771f26ae6bb@mail.gmail.com>
Date: Mon, 14 Aug 2006 17:43:08 +0200
From: "Metathronius Galabant" <m.galabant@googlemail.com>
To: linux-kernel@vger.kernel.org
Subject: Problems connecting to www.itu.int with Kernel > 2.6.15
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got serious problems connecting to www.itu.int with Kernels > 2.6.15.
2.6.17.X seems to be especially bad and I also tested it with the
latest 2.6.17.8 (no change).
Receiving data is extremely slow, close to non-existing.
This was first observed with Squid, but is confirmed by using the
netcat utility:

#> echo -e "GET /home/index.html HTTP/1.0\n\n" | nc www.itu.int 80

Disabling ECN doesn't help.
tcp_congestion_control was set to bic and hybla - no change, too.
This issue further has been confirmed on 2 seperate servers connected
via 2 independent ISPs.

Does anyone have a clue?
Please include me on CC: as I'm not subscribed.

Kind regards,
M.

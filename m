Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262715AbVBYPJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbVBYPJq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 10:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbVBYPJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 10:09:45 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:17333 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262716AbVBYPJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 10:09:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=jazEfcEVPb/xyEtIEBkNixkQTt72hUK0ZAIOm5K/FymqYeCb5ePH8ePkegyzl8hV3aH34Cux+Dyev3e5xsdl5Pf6+ngPt80HIfnwmhcHSCIa0bFqGD52715FeqtBPld5LcvRFbEdIdg6Zx7QDxJ7e9CmmAOieNyqrf4nKsDj7Zg=
Message-ID: <1458d9610502250709388b07ab@mail.gmail.com>
Date: Fri, 25 Feb 2005 20:39:28 +0530
From: Sumit Narayan <talk2sumit@gmail.com>
Reply-To: Sumit Narayan <talk2sumit@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: IDE via USB
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an external IDE connector through USB port. Where could I get
the exact point inside the kernel, from where I would get information
such as Block No., Request size, partition details for a particular
request, _just_ before being sent to the disk.

Like, for a normal IDE, I could gather these details from inside the
function __ide_do_rw_disk from "struct request". Is there anyway for
finding out the same for a USB mass storage device?

Thanks.

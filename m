Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbVKXOBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbVKXOBq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 09:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbVKXOBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 09:01:46 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:44611 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751023AbVKXOBp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 09:01:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=j01Lnb2pGyG/haH+qtloOzGtz7wKv4r4o4OubuYpNbead++t5R9GPEPc0OyUZLWQfJZNQZREHD2f0XvzDWpy3LXnys+2+3UGdvPKupClyvl0hHisLHPpdK1gyT3iJxqNhpoUCD9DhK4YHgiXqaMLJ/C6cl4tQW+IFe12DuVVCQw=
Message-ID: <6c18a4f0511240601i5860f724rff4db0c1b1fdca1e@mail.gmail.com>
Date: Thu, 24 Nov 2005 15:01:43 +0100
From: Bernd Bartmann <bernd.bartmann@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: S.M.A.R.T. command passthru to Firewire devices
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to run "smartctl -a /dev/sdb" it tells me that "Device does
not support SMART". /dev/sdb is a normal hdd in an external firewire
enclosure. To me this looks like the firewire SCSI layer does not
support the passthru of the S.M.A.R.T. commands. Or is there any other
way to query the S.M.A.R.T. status of an hdd attached via Firewire?

Thanks,
Bernd.

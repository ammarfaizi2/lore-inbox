Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVGRO5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVGRO5T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 10:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVGRO5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 10:57:19 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:42333 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261389AbVGRO5R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 10:57:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PSdB2lHnYirjobHt4gmXsxChPZqZeT0eQbV8dsyu36OOYQ+0EkKoMHBobwaIY4gHmO4rkkh8AND5gNLuM2bVjrvyeQ83T37nKbn6wldXEPPNqjzUsUCyKNr3a3l2U/UpDIWNuKKxUa50qo+0BoIMeguJ80BZKPznHvoFXgI+RlA=
Message-ID: <3faf0568050718075677c13e8@mail.gmail.com>
Date: Mon, 18 Jul 2005 20:26:53 +0530
From: vamsi krishna <vamsi.krishnak@gmail.com>
Reply-To: vamsi krishna <vamsi.krishnak@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Avoiding BIGMEM support programatically.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I have a program working fine on a 2.6.xx-smp kernel, and the program
crashes on the same version kernel with bigmem i.e (2.6.xxx-bigmem).

I also found that for a same executable on bigmem kernel the virtual
address's of '&_start' and '&_etext', seem to vary in every new run.

Is there any way I can avoid the kernel's bigmem virtual address
mapping programatically? and still run the program on a bigmem kernel?

Really appreciate your help in this context.

Best Regards,
Vamsi Kundeti.

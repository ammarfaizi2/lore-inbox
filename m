Return-Path: <linux-kernel-owner+w=401wt.eu-S932583AbXAJFfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbXAJFfs (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 00:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbXAJFfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 00:35:48 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:40920 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932577AbXAJFfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 00:35:47 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=q1exD4UMowVUBBTu9r9ii4egbJkaGQnwAkeMT6p86irdhfEqozZ5Yn8xrjSYtFtCuzgF5wFWK2cCi98AcoAJlXVPDZma98HoM6esFyy5p36jZBTuuV5H+VwZQ01SpFwuor9urYWX0DIHJujLTsus9xHu7gRk6Zx6OdjkUsByRxk=
Subject: [PATCHSET] Managed device resources, take #2
In-Reply-To: 
X-Mailer: git-send-email
Date: Wed, 10 Jan 2007 14:35:35 +0900
Message-Id: <11684073353213-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: jgarzik@pobox.com, gregkh@suse.de, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       htejun@gmail.com
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is the second take of devres patchset.  Changes from the last
take[L] are...

* generic managed iomap interface functions implemented
	- devm_ioport_map/unmap()
	- devm_ioremap[_nocache](), devm_iounmap()

* libata-sff legacy mode now uses generic managed iomap interface
  intead of implementing its own devres

* all pata drivers have been converted

* Documentation/driver-model/devres.txt added

Git tree is available at the following URLs.

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=devres
  git://htj.dyndns.org/libata-tj devres

For detailed info, please read Documentation/driver-model/devres.txt.
Similar info can also be found from the last post.

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/14690



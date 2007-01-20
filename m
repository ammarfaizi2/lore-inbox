Return-Path: <linux-kernel-owner+w=401wt.eu-S965094AbXATHAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbXATHAd (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 02:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbXATHAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 02:00:33 -0500
Received: from wx-out-0506.google.com ([66.249.82.230]:8364 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965094AbXATHAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 02:00:32 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=QNm3l9hmj+a5dvVwfZguSDfB2ZJ14x3kdhhO89d1V+BuQz1+gC5uTmY28M24wa/JCjliB+5/JRzpCAu0QwQ12CO02fUXwz+mGfl3BvLoeM7rQrv2DGef6UlQ4b/xDVn007GFR4QnybNQtOXBqyP9pGb/hucDgb14ssu3ARfaAHQ=
Subject: [PATCHSET] Managed device resources, take #3
In-Reply-To: 
X-Mailer: git-send-email
Date: Sat, 20 Jan 2007 16:00:26 +0900
Message-Id: <11692764262700-git-send-email-htejun@gmail.com>
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

This is the third iteration of devres patchset.  Changes from the last
take[L] are...

* devres patches collapsed into one as Jeff requested

* updates for sata_inic162x added

* rebased to the current upstream

Git tree is available at the following URLs.

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=devres
  git://htj.dyndns.org/libata-tj devres

For detailed info, please read Documentation/driver-model/devres.txt.
Similar info can also be found from the initial take[I].

This patchset is against

[U]   libata-dev#upstream
[1] + sata_promise-kill-qc-nsect
[2] + lbiata-fix-compile-warning-caused-by-ignoring-__must_check results

The git tree contains both previous patches, but this patchset apply
okay with either one of or both patches omitted.

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.kernel/482455
[I] http://thread.gmane.org/gmane.linux.ide/14690
[U] 8ed22df2570dbb7df2bd161bb9381a6fd17de3d3
[1] http://article.gmane.org/gmane.linux.ide/15189
[2] http://article.gmane.org/gmane.linux.ide/15192



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbVLFMJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbVLFMJc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 07:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbVLFMJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 07:09:32 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:14116 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964955AbVLFMJb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 07:09:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gDgxVstD/IU9lxfz0m/gAWjFGYKifXSHj+bxuv08SXNs3FNPDtfDmZiiarkKRe3fciLEpCX52aLoWJ1UFTksgEpf0Sq2cJagXpZKqLN5i6Nf799tfifOdzYH07oKLYtfK/em/AxovYtzHe44Un2e4tB+fpy7Zbza8TKM+4Wj844=
Message-ID: <f69849430512060409k1798e377h442e42bbf17b0d8a@mail.gmail.com>
Date: Tue, 6 Dec 2005 04:09:30 -0800
From: kernel coder <lhrkernelcoder@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: zero copy
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
i'm trying to track the code flow of sendfile system call.Mine
ethernet card doesn't have scatter gather and checksum calculation
features.So stack should be making a copy of data.

Please tell me where in sendfile code flow,check for scatter gather
and cecksum features is made so that stack can decide whether to copy
data from user space or not.

lhrkernelcoder

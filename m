Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273004AbTGaLXt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 07:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273006AbTGaLXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 07:23:48 -0400
Received: from trappist.elis.UGent.be ([157.193.204.1]:17853 "EHLO
	trappist.elis.UGent.be") by vger.kernel.org with ESMTP
	id S273004AbTGaLXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 07:23:47 -0400
Subject: regression serial console 2.6.0-test1 -> test2
From: Frank Cornelis <Frank.Cornelis@elis.ugent.be>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Frank Cornelis <Frank.Cornelis@elis.ugent.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 31 Jul 2003 13:23:46 +0200
Message-Id: <1059650626.1012.5.camel@tom>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

'console=ttyS0,115200n8' worked fine for me until 2.6.0-test2 came
along. I still get the kernel boot/shutdown messages, but no more kernel
run-time messages. There were some changes to drivers/serial in
test1->test2 which may be related to it.
Anyone else noticed this?

Please CC me,
Frank.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbTI2SE7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 14:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264099AbTI2SEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 14:04:43 -0400
Received: from fep02.swip.net ([130.244.199.130]:35577 "EHLO
	fep02-svc.swip.net") by vger.kernel.org with ESMTP id S264098AbTI2R7p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:59:45 -0400
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: "alias char-major-13 hid" doesn't work
Date: Mon, 29 Sep 2003 19:59:43 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309291959.43329.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In 2.4.X kernels I use in /etc/modules.conf to get my mouse working
alias char-major-13 hid
post-install hid modprobe -k mousedev; modprobe -k input

when I converted to /etc/modprobe.conf
module autoloading doesn't work - when I by hand write "modprobe hid",
mouse starts to work

Where is problem?
List of valid part of /etc/modprobe.conf
alias char-major-13 hid
alias char-major-13-32 mousedev
install hid /sbin/modprobe --ignore-install hid && { modprobe -k mousedev; 
modprobe -k input; }

Michal


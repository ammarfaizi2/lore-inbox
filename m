Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271615AbTGQW3n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 18:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271617AbTGQW3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 18:29:42 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:1522 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id S271615AbTGQW3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 18:29:22 -0400
Message-ID: <3F1726DE.1020304@oracle.com>
Date: Fri, 18 Jul 2003 00:44:46 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [2.4.22-pre6] radeon busted both in fb and X
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't know if this has already been reported, but:

  when the code starts at bootup, screen goes wild with colored lines
  like in a bad TV transmission. Letting the boot sequence end and
  starting X afterwards yields no significant improvement - screen
  is slightly less wild but entirely unusable.

2.4.22-pre4 works fine.

base of RedHat 8.0 on a Dell Latitude C640, with this from lspci:

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500]

--alessandro

  "Prima di non essere sincera / Pensa che ti tradisci solo tu"
       (Vasco Rossi, 'Prima di partire per un lungo viaggio')


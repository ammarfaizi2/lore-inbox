Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276519AbRI2PHh>; Sat, 29 Sep 2001 11:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276520AbRI2PH1>; Sat, 29 Sep 2001 11:07:27 -0400
Received: from mailb.telia.com ([194.22.194.6]:64517 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S276519AbRI2PHT>;
	Sat, 29 Sep 2001 11:07:19 -0400
Message-Id: <200109291507.f8TF7jt07561@mailb.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: linux-kernel@vger.kernel.org
Subject: [SOLVED] wireless problems in 2.4.10 / 2.4.9-ac16
Date: Sat, 29 Sep 2001 17:02:47 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Problem:
My 802.11b "Ad-Hoc" net stopped working when going from 2.4.10-pre10 to -final
later I tested with 2.4.9-ac16, same problem.

The problem was really that the drivers (Prism-II) had been upgraded to handle
the standardized IBSS Ad-Hoc mode. But I had not upgraded my
bridge/router/firewall...

To force the old "demo mode" you can use the command:
> iwpriv ethX set_port3 1
But of cause it is better to upgrade to IBSS compliant mode.

Note:
 With earlier version of wireless tools the get_port3 always reported
 0 back to me... with the latest version 21 it works.

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden


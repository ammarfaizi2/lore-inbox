Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266629AbUAWSic (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 13:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266634AbUAWSic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 13:38:32 -0500
Received: from 62-43-5-49.user.ono.com ([62.43.5.49]:8639 "EHLO
	mortadelo.pirispons.net") by vger.kernel.org with ESMTP
	id S266629AbUAWSi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 13:38:29 -0500
Date: Fri, 23 Jan 2004 19:38:27 +0100
From: Kiko Piris <kernel@pirispons.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [2.6.2-rc1] unknown i2c symbols in bttv and friends
Message-ID: <20040123183827.GA928@pirispons.net>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I compiled 2.6.2-rc1 and I can't use my Pinnacle PCTV card because bbtv
module and friends refuse to load due to unknown i2c_* symbols. dmesg
relevant part is attached (kernel config is also - grep ^CONFIG -).

I suspect it's due to not setting these new options: CONFIG_I2C_DEBUG_CORE,
CONFIG_I2C_DEBUG_BUS and CONFIG_I2C_DEBUG_CHIP.

Please let me know if I should provide any additional information.

Thanks.

-- 
Kiko

--TB36FDmn/VVEgNH/
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="dmesg.gz"
Content-Transfer-Encoding: base64

H4sICKNnEUAAA2RtZXNnAO2YTU7DMBBG95zCO1Zp0/IjhMQN2LIOY3vaGmI7jJ0At8dpkQhS
40YIVBCzTPziGX9jvUVujWtfRGc0eqGgiS2hMC4irUDhtegWs7I8MUtVKU/p+c49Ov/sRAME
FhMm7vtFjbJdn245qNe+kiZ+sOHVSl+LHVdXoFMZpMMwaP0JntKBDc3ZeVnu3a8hLzFL9BU1
mS4VzGGRwIXVAag/6oS9NEZQm0rVBl3MNxenkhZCyqUK6PTk4GLrkDKxja+/VyNUXYYaRDsO
DTLLQcMcMhXjNO4raf3cRZcxdnuh9PEWlG0Yh4azGIWGvWXL9WC23C7bkCKzFlJ8o+CkEw4H
QfjUYoiV9bqt0zhWYGrUYh6kcfP0cnspRVEItQEqLDx4Kq4WRTkTSORJ3IjlxeUvGCd7i73F
3vo/3jr+INg4bBw2DhuHjcPGYeOwcdg4bBw2DhvnLxuH/waxt9hb7K2/5q3jD4KNw8Zh47Bx
2DhsHDYOG+f7jfMG1DSb1EEkAAA=

--TB36FDmn/VVEgNH/
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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
/9IobY7uzlry+xT8/w8OzuaGER8AAA==

--TB36FDmn/VVEgNH/--

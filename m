Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268243AbUHQNV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268243AbUHQNV1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 09:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268237AbUHQNUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 09:20:48 -0400
Received: from main.gmane.org ([80.91.224.249]:50318 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268231AbUHQNUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 09:20:08 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Henning Rohde <Rohde.Henning@gmx.net>
Subject: 2.6: no input on audigy using snd_emu10k1
Date: Tue, 17 Aug 2004 14:20:49 +0200
Message-ID: <2083534.LoThlOV4Wx@rohde-29233.user.cis.dfn.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1709464.2tiJmRuEGA"
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p508852ab.dip0.t-ipconnect.de
User-Agent: KNode/0.7.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1709464.2tiJmRuEGA
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8Bit

Hi Everybody,

since quite a while no I'm unable to use any input-channels on my SB Audigy.

Alsamixer shows any channel I'm used to see, but I'm unable to toggle the
Capture facility on any channel I consider to be input.
On kmixer it's the same, there's not even one channel on the tab
"Eingang" (aka Input).

# modinfo snd_emu10k1 | grep vermagic
vermagic:       2.6.8-gentoo preempt K7 REGPARM 4KSTACKS gcc-3.3

# lspci -v -d 1102:0004
0000:00:0d.0 Multimedia audio controller: Creative Labs SB Audigy (rev 03)
        Subsystem: Creative Labs SB0090 Audigy Player/OEM
        Flags: bus master, medium devsel, latency 64, IRQ 193
        I/O ports at cc00
        Capabilities: [dc] Power Management version 2


Are any mor information needed?

Thanks very much in advance,

        Henning Rohde
--nextPart1709464.2tiJmRuEGA
Content-Type: application/x-gzip; name="amixer -c 1 contents.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="amixer -c 1 contents.gz"

H4sICFfwIUEAA2FtaXhlciAtYyAxIGNvbnRlbnRzAM2YXW/aMBSG7/kVvuumBS0fwNpN0QQhTFSk
oIKm3rrBUIvEjhK7wL9fykcb0AmhgVi7yJ3Jc97z8R4TJkM6tc1bjc6wT2yv/+Q+agyHxL7xcCJI
jEYBXj9jf4H+8kCG5KaG0C8k1hGx+w8T9096HPs+SRI7Xtbrde0VB5IktqmFlNm6FuKVbei6lr4q
svX0tz/R7oSu6TW2pTcB+oQzghzORMwDVEcdnCQl0I0C8o9i8nhJhf+SYXeGw4HbfoDZWQ5nGmd7
UquYNInJc1AmwQUqLQA9cjzkEFa+wEZxgXd4Iwffi1PlCtqrkcMf9NzKtZs57LGMYy7ZVIF8aLje
QqieDA3Xpu9wJGRMKjQUKO0KU25CE6do2kyo3VW0OmRwnkyoryDh4PrasCvvNQPSPaCMmArY0Gxv
2QpsFRqyN/gH+1Or0zhcnXsKNEqHlNIKLeO0QGiSnO515UEVzDIqEwdtZS8dmA7niUBfvpn6tPP1
Im13OYTqW9PQc9CVT6QF7rwXfuWpsCDDO8KUtnm4c/Zk+DqBxhHBi+x6u4ZKyFohVvmN1jy1SaEu
asuVCmOHZmeDVuDrUG+l7Ov6Xo7A6o3PgFy97zp3zVs0jAT1caCgvtBWOwpCwTUVKsJRFI94WbLw
uX+FjeYJ7jurS2ZYBiIre3OiuMl+v9/MoAHO42iUTclq86bSPGinFvDMS3jQDayAZ13Aa0Lef8zz
cLLIL1q9GAKZPggprNgZMGhdn4Lll+sMGGSsp2D5tSqGgSbOcMDnyKMrBQ4HZTYTgIJLYAsy2bac
0vkabSP53qVzKlKXG0oRSYHu04AuWmsGNJE7ZHqrrz7rkAN98BV8bIL6zl0JEqcJR+0wCuiMkvii
JJuQSFUfE639Thk53l5e7wm9cpq+F4WH5ndKW6txvB9ns/OfTx7/v5/aP+pSZSuFGAAA
--nextPart1709464.2tiJmRuEGA
Content-Type: application/x-gzip; name="proc_asound_card1_emu10k1.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="proc_asound_card1_emu10k1.gz"

H4sICMTxIUEAA3Byb2NfYXNvdW5kX2NhcmQxX2VtdTEwazEA7ZZdb9owFIbv/SvO5SYx1XGgtJMQ
YglsaKVFsE3TUC9S4kBEsCPHbst+/ZwPSrCXTmK72AXc8b7nHB8/J7Y8nHx18GcHIS8QIVi/9zBQ
YbzaoTGTVLAggS+zwQTePHERZm+1jZ8JxhgNn5tsjNAwiuhSwpyyEGZcyZitytI93IIPPacFXo+0
wO+5eRupVIKGMPoOd0qmSmZ5LILqH2AMi6k3gRsayfuD7BBYTMb+GGb0kYqHe4QGSXJcpNzQHyth
p5Rn8Wp9pJNSnyshuNJbMfNcw7cKtKsWzcTOvnUz4bKs6NEcft3oVp2PhnX1Chb9fr+uXJuKgy3F
sRQT5cFxK8dbc6GyutO2qnQs5dJSupai9zDwvQIRXIDnz+400YupPx5ZE78uQwtqZqyJkuC8c0+H
/eB8C9/ikHKzINEkaq5VQmP5fSfEfXGsJIsLsbgQiwuxuBBrtsSarWvN1t3PFlXt7b8LNBU8olkW
8/zMTnhIq9POOLrlsjj0HPxABoeLQFseT3eiwH18R+xohobbdB1kcQaGxzij6GUFw8T6vEu64mIH
Xj0kvzgcgj5SRkUgdZcwl4FUWWVy3USsO0dzrsSSwiTINmbddcAYTeBWbR+oODiJHh2aB9s0oTDT
ax+lta/0XfbpJ/ISvtzAYLlUIljuDr6j7TTdmjidM85/iZNcuGegfwfU898dLsNGmDmWJpq5dwrO
biNL9xWW3eh0lk6nEaa2mlA6nVc4KrZh/Intv8sbHUXDWjKPIlRUNJy9N8xkvNV+CPXlq9dQudEE
UiVSntHzkP7HIeXvAO0UL4GTq/wCTAtDqFwLAAA=
--nextPart1709464.2tiJmRuEGA--


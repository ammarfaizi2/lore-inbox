Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbVLDOMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbVLDOMj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 09:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVLDOMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 09:12:39 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:59535 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932230AbVLDOMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 09:12:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=iNQ+cZ4ZX6GSNNE6hqO32TP3Lp37U4lychRnc32mKWxg059p726jnc5WnVpcq2yZ+jk1tgG8Aqu3GKg5LcWqvrwSke1cqXqeDQSP5ddpDW5RXbJCclklV85s/hItoBWQ+nBMVkryMvR1jT1Y/YAMgTvTe5EkV8/mNS3W5vq7g3I=
Message-ID: <8b12046a0512040612q45ee06ecv880ba775e3699561@mail.gmail.com>
Date: Sun, 4 Dec 2005 14:12:35 +0000
From: Subodh Shrivastava <subodh.shrivastava@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc4
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_18005_23421961.1133705555364"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_18005_23421961.1133705555364
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

ipw2100 in-kernel dirver associates with AP when using wpa_supplicant
for WPA-PSK key management. But after few minutes it disassociates
itself from the AP.

Attached below are the debug output from ipw2100 driver and my
.config. Please let me know if you need any more information.


--
Subodh

------=_Part_18005_23421961.1133705555364
Content-Type: application/octet-stream; name=ipw2100.debug
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ipw2100.debug"

Dec  4 13:31:32 shannah ipw2100: U ipw2100_wx_set_scan Initiating scan...
Dec  4 13:31:32 shannah ipw2100: U ipw2100_set_scan_options enter
Dec  4 13:31:32 shannah ipw2100: U ipw2100_set_scan_options setting scan options
Dec  4 13:31:32 shannah ipw2100: U ipw2100_hw_send_command Sending SET_SCAN_OPTIONS command (#46), 8 bytes
Dec  4 13:31:32 shannah 00000000 00 00 00 00 00 00 00 00                            ........         
Dec  4 13:31:32 shannah ipw2100: I isr_rx_complete_command Command completed 'SET_SCAN_OPTIONS (46)'
Dec  4 13:31:32 shannah ipw2100: U ipw2100_set_scan_options SET_SCAN_OPTIONS 0x0000
Dec  4 13:31:32 shannah ipw2100: U ipw2100_start_scan START_SCAN
Dec  4 13:31:32 shannah ipw2100: U ipw2100_start_scan Scan requested while already in scan...
Dec  4 13:31:33 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCAN_COMPLETE
Dec  4 13:31:33 shannah ipw2100: I isr_scan_complete scan complete
Dec  4 13:31:33 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:33 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:33 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:33 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:33 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:33 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:33 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCAN_COMPLETE
Dec  4 13:31:33 shannah ipw2100: I isr_scan_complete scan complete
Dec  4 13:31:33 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:33 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:33 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:33 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:33 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:33 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:33 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCAN_COMPLETE
Dec  4 13:31:33 shannah ipw2100: I isr_scan_complete scan complete
Dec  4 13:31:33 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:33 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:34 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:34 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:34 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:34 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:34 shannah ipw2100: U ipw2100_disable_adapter CARD_DISABLE
Dec  4 13:31:34 shannah ipw2100: U ipw2100_hw_send_command Sending CARD_DISABLE command (#44), 0 bytes
Dec  4 13:31:34 shannah ipw2100: I isr_rx_complete_command Command completed 'CARD_DISABLE (44)'
Dec  4 13:31:34 shannah ipw2100: I isr_status_change Status change: IPW_STATE_DISABLED
Dec  4 13:31:34 shannah ipw2100: U ipw2100_disable_adapter TODO: implement scan state machine
Dec  4 13:31:34 shannah ipw2100: U ipw2100_set_security_information SET_SECURITY_INFORMATION: auth:0 cipher:0x01 (level 0)
Dec  4 13:31:34 shannah ipw2100: U ipw2100_hw_send_command Sending SET_SECURITY_INFORMATION command (#67), 9 bytes
Dec  4 13:31:34 shannah 00000000 01 00 00 00 00 00 00 00  00                        ........ .       
Dec  4 13:31:34 shannah ipw2100: I isr_rx_complete_command Command completed 'SET_SECURITY_INFORMATION (67)'
Dec  4 13:31:34 shannah ipw2100: U ipw2100_set_wep_flags WEP_FLAGS: flags = 0x00000000
Dec  4 13:31:34 shannah ipw2100: U ipw2100_hw_send_command Sending WEP_FLAGS command (#26), 4 bytes
Dec  4 13:31:34 shannah 00000000 00 00 00 00                                        ....             
Dec  4 13:31:34 shannah ipw2100: I isr_rx_complete_command Command completed 'WEP_FLAGS (26)'
Dec  4 13:31:34 shannah ipw2100: U ipw2100_enable_adapter HOST_COMPLETE
Dec  4 13:31:34 shannah ipw2100: U ipw2100_hw_send_command Sending HOST_COMPLETE command (#2), 0 bytes
Dec  4 13:31:34 shannah ipw2100: I isr_rx_complete_command Command completed 'HOST_COMPLETE (2)'
Dec  4 13:31:34 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:34 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:34 shannah ipw2100: U ipw2100_disable_adapter CARD_DISABLE
Dec  4 13:31:34 shannah ipw2100: U ipw2100_hw_send_command Sending CARD_DISABLE command (#44), 0 bytes
Dec  4 13:31:34 shannah ipw2100: I isr_rx_complete_command Command completed 'CARD_DISABLE (44)'
Dec  4 13:31:34 shannah ipw2100: I isr_status_change Status change: IPW_STATE_DISABLED
Dec  4 13:31:34 shannah ipw2100: U ipw2100_disable_adapter TODO: implement scan state machine
Dec  4 13:31:34 shannah ipw2100: U ipw2100_set_security_information SET_SECURITY_INFORMATION: auth:0 cipher:0x22 (level 1)
Dec  4 13:31:34 shannah ipw2100: U ipw2100_hw_send_command Sending SET_SECURITY_INFORMATION command (#67), 9 bytes
Dec  4 13:31:34 shannah 00000000 22 00 00 00 00 00 00 00  00                        "....... .       
Dec  4 13:31:34 shannah ipw2100: I isr_rx_complete_command Command completed 'SET_SECURITY_INFORMATION (67)'
Dec  4 13:31:34 shannah ipw2100: U ipw2100_set_key_index WEP_KEY_INDEX: index = 0
Dec  4 13:31:34 shannah ipw2100: U ipw2100_hw_send_command Sending WEP_KEY_INDEX command (#25), 4 bytes
Dec  4 13:31:34 shannah 00000000 00 00 00 00                                        ....             
Dec  4 13:31:34 shannah ipw2100: I isr_rx_complete_command Command completed 'WEP_KEY_INDEX (25)'
Dec  4 13:31:34 shannah ipw2100: U ipw2100_set_wep_flags WEP_FLAGS: flags = 0x00000008
Dec  4 13:31:34 shannah ipw2100: U ipw2100_hw_send_command Sending WEP_FLAGS command (#26), 4 bytes
Dec  4 13:31:34 shannah 00000000 08 00 00 00                                        ....             
Dec  4 13:31:34 shannah ipw2100: I isr_rx_complete_command Command completed 'WEP_FLAGS (26)'
Dec  4 13:31:34 shannah ipw2100: U ipw2100_enable_adapter HOST_COMPLETE
Dec  4 13:31:34 shannah ipw2100: U ipw2100_hw_send_command Sending HOST_COMPLETE command (#2), 0 bytes
Dec  4 13:31:34 shannah ipw2100: I isr_rx_complete_command Command completed 'HOST_COMPLETE (2)'
Dec  4 13:31:34 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:34 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:34 shannah ipw2100: U ipw2100_wx_set_mode SET Mode -> 2 
Dec  4 13:31:34 shannah ipw2100: U ipw2100_set_wpa_ie SET_WPA_IE
Dec  4 13:31:34 shannah ipw2100: U ipw2100_disable_adapter CARD_DISABLE
Dec  4 13:31:34 shannah ipw2100: U ipw2100_hw_send_command Sending CARD_DISABLE command (#44), 0 bytes
Dec  4 13:31:34 shannah ipw2100: I isr_rx_complete_command Command completed 'CARD_DISABLE (44)'
Dec  4 13:31:34 shannah ipw2100: I isr_status_change Status change: IPW_STATE_DISABLED
Dec  4 13:31:34 shannah ipw2100: U ipw2100_disable_adapter TODO: implement scan state machine
Dec  4 13:31:34 shannah ipw2100: U ipw2100_hw_send_command Sending SET_WPA_ASS_IE command (#69), 400 bytes
Dec  4 13:31:34 shannah 00000000 00 00 00 00 BE D5 A9 E1  F0 C6 D4 DD 18 00 00 00   ........ ........
Dec  4 13:31:34 shannah 00000010 DD 16 00 50 F2 01 01 00  00 50 F2 02 01 00 00 50   ...P.... .P.....P
Dec  4 13:31:34 shannah 00000020 F2 02 01 00 00 50 F2 02  80 01 00 00 04 00 00 00   .....P.. ........
Dec  4 13:31:34 shannah 00000030 01 DA A9 E1 F0 C6 D4 DD  00 00 00 00 00 00 00 00   ........ ........
Dec  4 13:31:34 shannah 00000040 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   ........ ........
Dec  4 13:31:34 shannah 00000050 00 00 00 00 AC 5D 91 D3  FF FF FF FF C0 BB 39 C0   .....].. ......9.
Dec  4 13:31:34 shannah 00000060 00 00 00 00 20 00 00 00  00 00 00 20 F0 C6 D4 DD   .... ... ... ....
Dec  4 13:31:34 shannah 00000070 A0 28 F8 FD 32 BB 08 00  08 34 5E 4B C0 A3 37 DF   .(..2... .4^K..7.
Dec  4 13:31:34 shannah 00000080 F0 A0 32 DF F0 A0 32 DF  0A 7E FF E7 94 5D 91 D3   ..2...2. .~...]..
Dec  4 13:31:34 shannah 00000090 2D 49 11 C0 F0 A0 32 DF  50 DF 46 C0 2E 02 00 00   -I....2. P.F.....
Dec  4 13:31:34 shannah 000000A0 F0 A0 32 DF A8 5D 91 D3  01 00 00 00 B4 5D 91 D3   ..2..].. .....]..
Dec  4 13:31:34 shannah 000000B0 96 00 00 00 F0 A0 32 DF  20 DF 46 C0 01 00 00 00   ......2.  .F.....
Dec  4 13:31:34 shannah 000000C0 96 00 00 00 00 00 00 00  CC 81 3E C0 D8 5D 91 D3   ........ ..>..]..
Dec  4 13:31:34 shannah 000000D0 D8 52 11 C0 F0 A0 32 DF  01 00 00 00 00 00 00 00   .R....2. ........
Dec  4 13:31:34 shannah 000000E0 00 00 00 00 00 00 00 00  82 02 00 00 EF EC 46 C0   ........ ......F.
Dec  4 13:31:34 shannah 000000F0 86 02 00 00 82 02 00 00  00 00 00 00 92 02 00 00   ........ ........
Dec  4 13:31:34 shannah 00000100 00 23 4F D4 10 5E 91 D3  92 02 00 00 00 AC 40 C0   .#O..^.. ......@.
Dec  4 13:31:34 shannah 00000110 03 00 00 00 01 00 00 00  00 00 00 00 00 00 00 00   ........ ........
Dec  4 13:31:34 shannah 00000120 00 D0 F4 DC 00 00 00 00  2C 5E 91 D3 F6 8A 35 C0   ........ ,^....5.
Dec  4 13:31:34 shannah 00000130 00 00 00 00 2C 00 00 00  EC F0 FF FF 20 00 00 00   ....,... .... ...
Dec  4 13:31:34 shannah 00000140 00 23 4F D4 00 9E F5 DF  00 00 00 00 01 00 00 00   .#O..... ........
Dec  4 13:31:34 shannah 00000150 00 00 00 00 00 00 00 00  01 00 00 00 20 00 00 00   ........ .... ...
Dec  4 13:31:34 shannah 00000160 00 23 4F D4 00 00 00 00  E8 0F 00 00 0C 00 00 00   .#O..... ........
Dec  4 13:31:34 shannah 00000170 0C 00 00 00 28 6F 5E FE  9F BB 08 00 C0 F0 F6 DF   ....(o^. ........
Dec  4 13:31:34 shannah 00000180 60 C2 D4 DD 86 02 00 00  B9 19 00 00 08 5F 03 DD   `....... ....._..
Dec  4 13:31:34 shannah ipw2100: I isr_rx_complete_command Command completed 'SET_WPA_ASS_IE (69)'
Dec  4 13:31:34 shannah ipw2100: U ipw2100_enable_adapter HOST_COMPLETE
Dec  4 13:31:34 shannah ipw2100: U ipw2100_hw_send_command Sending HOST_COMPLETE command (#2), 0 bytes
Dec  4 13:31:34 shannah ipw2100: I isr_rx_complete_command Command completed 'HOST_COMPLETE (2)'
Dec  4 13:31:34 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:34 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:34 shannah ipw2100: U ipw2100_wx_set_essid ESSID set to current ESSID.
Dec  4 13:31:34 shannah ipw2100: U ipw2100_set_mandatory_bssid MANDATORY_BSSID: 00:09:5B:CB:30:BA
Dec  4 13:31:34 shannah ipw2100: U ipw2100_disable_adapter CARD_DISABLE
Dec  4 13:31:34 shannah ipw2100: U ipw2100_hw_send_command Sending CARD_DISABLE command (#44), 0 bytes
Dec  4 13:31:34 shannah ipw2100: I isr_rx_complete_command Command completed 'CARD_DISABLE (44)'
Dec  4 13:31:34 shannah ipw2100: I isr_status_change Status change: IPW_STATE_DISABLED
Dec  4 13:31:34 shannah ipw2100: U ipw2100_disable_adapter TODO: implement scan state machine
Dec  4 13:31:34 shannah ipw2100: U ipw2100_hw_send_command Sending MANDATORY_BSSID command (#9), 6 bytes
Dec  4 13:31:34 shannah 00000000 00 09 5B CB 30 BA                                  ..[.0.           
Dec  4 13:31:34 shannah ipw2100: I isr_rx_complete_command Command completed 'MANDATORY_BSSID (9)'
Dec  4 13:31:34 shannah ipw2100: U ipw2100_enable_adapter HOST_COMPLETE
Dec  4 13:31:34 shannah ipw2100: U ipw2100_hw_send_command Sending HOST_COMPLETE command (#2), 0 bytes
Dec  4 13:31:34 shannah ipw2100: I isr_rx_complete_command Command completed 'HOST_COMPLETE (2)'
Dec  4 13:31:34 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:34 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:34 shannah ipw2100: U ipw2100_wx_set_wap SET BSSID -> 00:09:5B:CB:30:BA
Dec  4 13:31:34 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:34 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:34 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:34 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:34 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCAN_COMPLETE
Dec  4 13:31:34 shannah ipw2100: I isr_scan_complete scan complete
Dec  4 13:31:34 shannah ipw2100: I isr_status_change Status change: IPW_STATE_ASSOCIATED
Dec  4 13:31:34 shannah ipw2100: I isr_indicate_associated eth0: Associated with 'subbuwifiBG' at 11Mbps, channel 11 (BSSID=00:09:5b:cb:30:ba)
Dec  4 13:31:34 shannah ipw2100: I isr_rx Dropping packet while not associated.
Dec  4 13:31:34 shannah ipw2100: U ipw2100_wx_event_work enter
Dec  4 13:31:34 shannah ipw2100: U ipw2100_wx_get_wap Getting WAP BSSID: 00:09:5b:cb:30:ba
Dec  4 13:31:36 shannah ipw2100: U ipw2100_wx_get_essid Getting essid: 'subbuwifiBG'
Dec  4 13:31:36 shannah ipw2100: U ipw2100_wx_get_wap Getting WAP BSSID: 00:09:5b:cb:30:ba
Dec  4 13:31:36 shannah ipw2100: I isr_rx eth0: Non consumed packet:
Dec  4 13:31:36 shannah 00000000 08 42 D5 00 00 04 23 51  CF 8F 00 09 5B CB 30 BA   .B....#Q ....[.0.
Dec  4 13:31:36 shannah 00000010 00 09 5B CB 30 BA 00 FB  00 20 00 20 00 00 00 00   ..[.0... . . ....
Dec  4 13:31:36 shannah 00000020 0C BC D6 A3 1B 2E 3B A7  75 12 C4 C9 81 D3 B6 26   ......;. u......&
Dec  4 13:31:36 shannah 00000030 71 0A 60 73 9C C4 E4 6F  2D 49 95 EA CC D6 4D 84   q.`s...o -I....M.
Dec  4 13:31:36 shannah 00000040 BC 93 2B 76 DC E8 83 D0  2F 5C 56 97 E9 38 EE 11   ..+v.... /\V..8..
Dec  4 13:31:36 shannah 00000050 60 1B BF 07 1B FD EF 64  8D D4 59 FA 3B 9D 54 D4   `......d ..Y.;.T.
Dec  4 13:31:36 shannah 00000060 F7 BB 9D 3A 76 B5 62 E0  A8 29 F0 17 86 C7 5D E1   ...:v.b. .)....].
Dec  4 13:31:36 shannah 00000070 4A A6 C0 60 C2 48 33 6C  D7 E4 61 BF 85 5B A2 17   J..`.H3l ..a..[..
Dec  4 13:31:36 shannah 00000080 DA 24 B1 8C C6 3C 3F 17  83 B8 CB 43 79 EF 68 04   .$...<?. ...Cy.h.
Dec  4 13:31:36 shannah 00000090 09 C9 4A 97 24 AA 09 3D  04 C4 9D 96 1B 1F 4B 53   ..J.$..= ......KS
Dec  4 13:31:36 shannah 000000A0 2B 15 08 F4 10 A0 24 6E  78 8D D1 76 28 9C 20 7F   +.....$n x..v(. .
Dec  4 13:31:36 shannah 000000B0 F7 92 46 D2 D7 68 7C                               ..F..h|          
Dec  4 13:31:38 shannah ipw2100: I isr_rx eth0: Non consumed packet:
Dec  4 13:31:38 shannah 00000000 08 42 D5 00 00 04 23 51  CF 8F 00 09 5B CB 30 BA   .B....#Q ....[.0.
Dec  4 13:31:38 shannah 00000010 00 09 5B CB 30 BA 40 FC  00 20 01 20 00 00 00 00   ..[.0.@. . . ....
Dec  4 13:31:38 shannah 00000020 BF E5 35 EA F6 17 84 70  25 2C 37 9E 58 62 73 66   ..5....p %,7.Xbsf
Dec  4 13:31:38 shannah 00000030 FC 34 F1 52 D0 44 67 E8  6E 27 DC 21 DB 23 A3 D3   .4.R.Dg. n'.!.#..
Dec  4 13:31:38 shannah 00000040 96 0F 51 11 A7 DC 19 37  C7 B2 83 7B 7C 80 15 D1   ..Q....7 ...{|...
Dec  4 13:31:38 shannah 00000050 77 05 10 7E E8 0F 61 F2  99 F2 53 53 FF 4F 20 76   w..~..a. ..SS.O v
Dec  4 13:31:38 shannah 00000060 FA EA CB 4B 02 79 00 0D  17 F9 12 F4 A3 98 A0 AE   ...K.y.. ........
Dec  4 13:31:38 shannah 00000070 ED 88 76 B6 A2 59 FC 58  14 3E E4 32 0D 40 5E F4   ..v..Y.X .>.2.@^.
Dec  4 13:31:38 shannah 00000080 47 A4 F5 F0 8E 78 19 7D  62 2B F5 BB 58 13 88 7A   G....x.} b+..X..z
Dec  4 13:31:38 shannah 00000090 F9 C2 98 CF 2C 53 CE F5  73 06 48 3C EA F4 9D E1   ....,S.. s.H<....
Dec  4 13:31:38 shannah 000000A0 6C 52 22 E4 16 A6 26 5C  B4 76 F2 B6 64 EA 6D 04   lR"...&\ .v..d.m.
Dec  4 13:31:38 shannah 000000B0 46 C0 AD 6C 8C 72 14                               F..l.r.          
Dec  4 13:31:40 shannah ipw2100: I isr_rx eth0: Non consumed packet:
Dec  4 13:31:40 shannah 00000000 08 42 D5 00 00 04 23 51  CF 8F 00 09 5B CB 30 BA   .B....#Q ....[.0.
Dec  4 13:31:40 shannah 00000010 00 09 5B CB 30 BA 90 FD  00 20 02 20 00 00 00 00   ..[.0... . . ....
Dec  4 13:31:40 shannah 00000020 DB 85 6E 74 16 F3 AC B4  0E 10 04 0B 29 F8 5D D1   ..nt.... ....).].
Dec  4 13:31:40 shannah 00000030 7A 1B E1 92 0F 4A 34 0C  1D 2F CF B6 1A 9C 95 AF   z....J4. ./......
Dec  4 13:31:40 shannah 00000040 4A 62 CF FE 0B 83 ED C6  EC 10 C2 25 CC 13 33 EB   Jb...... ...%..3.
Dec  4 13:31:40 shannah 00000050 39 FF 79 B1 97 1C DC 9D  00 14 11 AB 1E 0E BE 2D   9.y..... .......-
Dec  4 13:31:40 shannah 00000060 7F 82 2E AB 09 5A 65 18  8B B9 3F 58 EC 11 E1 12   .....Ze. ..?X....
Dec  4 13:31:40 shannah 00000070 6A 8E CE AC 3A EB 7E 88  57 06 04 25 6C 44 5B 57   j...:.~. W..%lD[W
Dec  4 13:31:40 shannah 00000080 BD 69 3D 72 B8 B8 A1 D5  EA 78 2A 4B 51 22 CD D3   .i=r.... .x*KQ"..
Dec  4 13:31:40 shannah 00000090 85 B0 83 F4 63 03 52 3A  9E D0 12 DD 84 1F 38 DF   ....c.R: ......8.
Dec  4 13:31:40 shannah 000000A0 3A 5E 23 02 56 53 7D F6  9A 1A 1F 11 DE D1 0F 08   :^#.VS}. ........
Dec  4 13:31:40 shannah 000000B0 43 B2 69 E1 D0 AE 86                               C.i....          
Dec  4 13:31:42 shannah ipw2100: I isr_rx eth0: Non consumed packet:
Dec  4 13:31:42 shannah 00000000 08 42 D5 00 00 04 23 51  CF 8F 00 09 5B CB 30 BA   .B....#Q ....[.0.
Dec  4 13:31:42 shannah 00000010 00 09 5B CB 30 BA D0 FE  00 20 03 20 00 00 00 00   ..[.0... . . ....
Dec  4 13:31:42 shannah 00000020 2D F7 EF 20 04 1D 01 91  25 AA 1A A4 95 BB 19 06   -.. .... %.......
Dec  4 13:31:42 shannah 00000030 74 E8 51 7E 1D B0 36 9D  B6 2F 01 34 32 5A E5 07   t.Q~..6. ./.42Z..
Dec  4 13:31:42 shannah 00000040 08 BE F8 5A 23 CD AB 85  79 13 CB A6 E8 38 D1 DF   ...Z#... y....8..
Dec  4 13:31:42 shannah 00000050 FE 80 0D F0 EF 3C 21 B6  45 F2 88 8B AB FD 85 5C   .....<!. E......\
Dec  4 13:31:42 shannah 00000060 D6 27 05 54 78 52 1D 87  B2 AF 61 C8 D0 DE A1 19   .'.TxR.. ..a.....
Dec  4 13:31:42 shannah 00000070 3E 29 DD 3A 1E 94 F7 40  A4 91 A8 D9 13 B4 77 C2   >).:...@ ......w.
Dec  4 13:31:42 shannah 00000080 00 C8 EA 06 B7 BC F6 6B  03 CA 61 C5 0C CA 3C 26   .......k ..a...<&
Dec  4 13:31:42 shannah 00000090 7F FC ED 67 BD 51 68 A1  16 83 CE 7A 46 C7 C7 95   ...g.Qh. ...zF...
Dec  4 13:31:42 shannah 000000A0 2A 9B 70 8F FA 02 A8 86  C3 A7 6D 8F E9 13 34 61   *.p..... ..m...4a
Dec  4 13:31:42 shannah 000000B0 D4 F0 4B 18 37 1E 1D                               ..K.7..          
Dec  4 13:31:44 shannah ipw2100: I isr_status_change Status change: IPW_STATE_ASSN_LOST
Dec  4 13:31:44 shannah ipw2100: I isr_indicate_association_lost disassociated: 'subbuwifiBG' 00:09:5b:cb:30:ba 
Dec  4 13:31:44 shannah ipw2100: U ipw2100_wx_event_work enter
Dec  4 13:31:44 shannah ipw2100: U ipw2100_wx_event_work Configuring ESSID
Dec  4 13:31:44 shannah ipw2100: U ipw2100_set_essid SSID: 'subbuwifiBG'
Dec  4 13:31:44 shannah ipw2100: U ipw2100_disable_adapter CARD_DISABLE
Dec  4 13:31:44 shannah ipw2100: U ipw2100_hw_send_command Sending CARD_DISABLE command (#44), 0 bytes
Dec  4 13:31:44 shannah ipw2100: I isr_rx_complete_command Command completed 'CARD_DISABLE (44)'
Dec  4 13:31:44 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:44 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:44 shannah ipw2100: I isr_status_change Status change: IPW_STATE_DISABLED
Dec  4 13:31:44 shannah ipw2100: U ipw2100_disable_adapter TODO: implement scan state machine
Dec  4 13:31:44 shannah ipw2100: U ipw2100_hw_send_command Sending SSID command (#8), 11 bytes
Dec  4 13:31:44 shannah 00000000 73 75 62 62 75 77 69 66  69 42 47                  subbuwif iBG     
Dec  4 13:31:44 shannah ipw2100: I isr_rx_complete_command Command completed 'SSID (8)'
Dec  4 13:31:44 shannah ipw2100: U ipw2100_enable_adapter HOST_COMPLETE
Dec  4 13:31:44 shannah ipw2100: U ipw2100_hw_send_command Sending HOST_COMPLETE command (#2), 0 bytes
Dec  4 13:31:44 shannah ipw2100: I isr_rx_complete_command Command completed 'HOST_COMPLETE (2)'
Dec  4 13:31:44 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:44 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:44 shannah ipw2100: U ipw2100_disable_adapter CARD_DISABLE
Dec  4 13:31:44 shannah ipw2100: U ipw2100_hw_send_command Sending CARD_DISABLE command (#44), 0 bytes
Dec  4 13:31:44 shannah ipw2100: I isr_rx_complete_command Command completed 'CARD_DISABLE (44)'
Dec  4 13:31:44 shannah ipw2100: I isr_status_change Status change: IPW_STATE_DISABLED
Dec  4 13:31:44 shannah ipw2100: U ipw2100_disable_adapter TODO: implement scan state machine
Dec  4 13:31:44 shannah ipw2100: U ipw2100_set_security_information SET_SECURITY_INFORMATION: auth:0 cipher:0x01 (level 0)
Dec  4 13:31:44 shannah ipw2100: U ipw2100_hw_send_command Sending SET_SECURITY_INFORMATION command (#67), 9 bytes
Dec  4 13:31:44 shannah 00000000 01 00 00 00 00 00 00 00  00                        ........ .       
Dec  4 13:31:44 shannah ipw2100: I isr_rx_complete_command Command completed 'SET_SECURITY_INFORMATION (67)'
Dec  4 13:31:44 shannah ipw2100: U ipw2100_set_wep_flags WEP_FLAGS: flags = 0x00000000
Dec  4 13:31:44 shannah ipw2100: U ipw2100_hw_send_command Sending WEP_FLAGS command (#26), 4 bytes
Dec  4 13:31:44 shannah 00000000 00 00 00 00                                        ....             
Dec  4 13:31:44 shannah ipw2100: I isr_rx_complete_command Command completed 'WEP_FLAGS (26)'
Dec  4 13:31:44 shannah ipw2100: U ipw2100_enable_adapter HOST_COMPLETE
Dec  4 13:31:44 shannah ipw2100: U ipw2100_hw_send_command Sending HOST_COMPLETE command (#2), 0 bytes
Dec  4 13:31:44 shannah ipw2100: I isr_rx_complete_command Command completed 'HOST_COMPLETE (2)'
Dec  4 13:31:44 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:44 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:44 shannah ipw2100: U ipw2100_disable_adapter CARD_DISABLE
Dec  4 13:31:44 shannah ipw2100: U ipw2100_hw_send_command Sending CARD_DISABLE command (#44), 0 bytes
Dec  4 13:31:44 shannah ipw2100: I isr_rx_complete_command Command completed 'CARD_DISABLE (44)'
Dec  4 13:31:44 shannah ipw2100: I isr_status_change Status change: IPW_STATE_DISABLED
Dec  4 13:31:44 shannah ipw2100: U ipw2100_disable_adapter TODO: implement scan state machine
Dec  4 13:31:44 shannah ipw2100: U ipw2100_set_security_information SET_SECURITY_INFORMATION: auth:0 cipher:0x01 (level 0)
Dec  4 13:31:44 shannah ipw2100: U ipw2100_hw_send_command Sending SET_SECURITY_INFORMATION command (#67), 9 bytes
Dec  4 13:31:44 shannah 00000000 01 00 00 00 00 00 00 00  00                        ........ .       
Dec  4 13:31:44 shannah ipw2100: I isr_rx_complete_command Command completed 'SET_SECURITY_INFORMATION (67)'
Dec  4 13:31:44 shannah ipw2100: U ipw2100_set_wep_flags WEP_FLAGS: flags = 0x00000000
Dec  4 13:31:44 shannah ipw2100: U ipw2100_hw_send_command Sending WEP_FLAGS command (#26), 4 bytes
Dec  4 13:31:44 shannah 00000000 00 00 00 00                                        ....             
Dec  4 13:31:44 shannah ipw2100: I isr_rx_complete_command Command completed 'WEP_FLAGS (26)'
Dec  4 13:31:44 shannah ipw2100: U ipw2100_enable_adapter HOST_COMPLETE
Dec  4 13:31:44 shannah ipw2100: U ipw2100_hw_send_command Sending HOST_COMPLETE command (#2), 0 bytes
Dec  4 13:31:44 shannah ipw2100: I isr_rx_complete_command Command completed 'HOST_COMPLETE (2)'
Dec  4 13:31:44 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:44 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:44 shannah ipw2100: U ipw2100_disable_adapter CARD_DISABLE
Dec  4 13:31:44 shannah ipw2100: U ipw2100_hw_send_command Sending CARD_DISABLE command (#44), 0 bytes
Dec  4 13:31:44 shannah ipw2100: I isr_rx_complete_command Command completed 'CARD_DISABLE (44)'
Dec  4 13:31:44 shannah ipw2100: I isr_status_change Status change: IPW_STATE_DISABLED
Dec  4 13:31:44 shannah ipw2100: U ipw2100_disable_adapter TODO: implement scan state machine
Dec  4 13:31:44 shannah ipw2100: U ipw2100_set_security_information SET_SECURITY_INFORMATION: auth:0 cipher:0x01 (level 0)
Dec  4 13:31:44 shannah ipw2100: U ipw2100_hw_send_command Sending SET_SECURITY_INFORMATION command (#67), 9 bytes
Dec  4 13:31:44 shannah 00000000 01 00 00 00 00 00 00 00  00                        ........ .       
Dec  4 13:31:44 shannah ipw2100: I isr_rx_complete_command Command completed 'SET_SECURITY_INFORMATION (67)'
Dec  4 13:31:44 shannah ipw2100: U ipw2100_set_wep_flags WEP_FLAGS: flags = 0x00000000
Dec  4 13:31:44 shannah ipw2100: U ipw2100_hw_send_command Sending WEP_FLAGS command (#26), 4 bytes
Dec  4 13:31:44 shannah 00000000 00 00 00 00                                        ....             
Dec  4 13:31:44 shannah ipw2100: I isr_rx_complete_command Command completed 'WEP_FLAGS (26)'
Dec  4 13:31:44 shannah ipw2100: U ipw2100_enable_adapter HOST_COMPLETE
Dec  4 13:31:44 shannah ipw2100: U ipw2100_hw_send_command Sending HOST_COMPLETE command (#2), 0 bytes
Dec  4 13:31:44 shannah ipw2100: I isr_rx_complete_command Command completed 'HOST_COMPLETE (2)'
Dec  4 13:31:44 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:44 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:44 shannah ipw2100: U ipw2100_disable_adapter CARD_DISABLE
Dec  4 13:31:44 shannah ipw2100: U ipw2100_hw_send_command Sending CARD_DISABLE command (#44), 0 bytes
Dec  4 13:31:44 shannah ipw2100: I isr_rx_complete_command Command completed 'CARD_DISABLE (44)'
Dec  4 13:31:44 shannah ipw2100: I isr_status_change Status change: IPW_STATE_DISABLED
Dec  4 13:31:44 shannah ipw2100: U ipw2100_disable_adapter TODO: implement scan state machine
Dec  4 13:31:44 shannah ipw2100: U ipw2100_set_security_information SET_SECURITY_INFORMATION: auth:0 cipher:0x01 (level 0)
Dec  4 13:31:44 shannah ipw2100: U ipw2100_hw_send_command Sending SET_SECURITY_INFORMATION command (#67), 9 bytes
Dec  4 13:31:44 shannah 00000000 01 00 00 00 00 00 00 00  00                        ........ .       
Dec  4 13:31:44 shannah ipw2100: I isr_rx_complete_command Command completed 'SET_SECURITY_INFORMATION (67)'
Dec  4 13:31:44 shannah ipw2100: U ipw2100_set_wep_flags WEP_FLAGS: flags = 0x00000000
Dec  4 13:31:44 shannah ipw2100: U ipw2100_hw_send_command Sending WEP_FLAGS command (#26), 4 bytes
Dec  4 13:31:44 shannah 00000000 00 00 00 00                                        ....             
Dec  4 13:31:44 shannah ipw2100: I isr_rx_complete_command Command completed 'WEP_FLAGS (26)'
Dec  4 13:31:45 shannah ipw2100: U ipw2100_enable_adapter HOST_COMPLETE
Dec  4 13:31:45 shannah ipw2100: U ipw2100_hw_send_command Sending HOST_COMPLETE command (#2), 0 bytes
Dec  4 13:31:45 shannah ipw2100: I isr_rx_complete_command Command completed 'HOST_COMPLETE (2)'
Dec  4 13:31:45 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:45 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:45 shannah ipw2100: U ipw2100_disable_adapter CARD_DISABLE
Dec  4 13:31:45 shannah ipw2100: U ipw2100_hw_send_command Sending CARD_DISABLE command (#44), 0 bytes
Dec  4 13:31:45 shannah ipw2100: I isr_rx_complete_command Command completed 'CARD_DISABLE (44)'
Dec  4 13:31:45 shannah ipw2100: I isr_status_change Status change: IPW_STATE_DISABLED
Dec  4 13:31:45 shannah ipw2100: U ipw2100_disable_adapter TODO: implement scan state machine
Dec  4 13:31:45 shannah ipw2100: U ipw2100_set_security_information SET_SECURITY_INFORMATION: auth:0 cipher:0x01 (level 0)
Dec  4 13:31:45 shannah ipw2100: U ipw2100_hw_send_command Sending SET_SECURITY_INFORMATION command (#67), 9 bytes
Dec  4 13:31:45 shannah 00000000 01 00 00 00 00 00 00 00  00                        ........ .       
Dec  4 13:31:45 shannah ipw2100: I isr_rx_complete_command Command completed 'SET_SECURITY_INFORMATION (67)'
Dec  4 13:31:45 shannah ipw2100: U ipw2100_set_wep_flags WEP_FLAGS: flags = 0x00000000
Dec  4 13:31:45 shannah ipw2100: U ipw2100_hw_send_command Sending WEP_FLAGS command (#26), 4 bytes
Dec  4 13:31:45 shannah 00000000 00 00 00 00                                        ....             
Dec  4 13:31:45 shannah ipw2100: I isr_rx_complete_command Command completed 'WEP_FLAGS (26)'
Dec  4 13:31:45 shannah ipw2100: U ipw2100_enable_adapter HOST_COMPLETE
Dec  4 13:31:45 shannah ipw2100: U ipw2100_hw_send_command Sending HOST_COMPLETE command (#2), 0 bytes
Dec  4 13:31:45 shannah ipw2100: I isr_rx_complete_command Command completed 'HOST_COMPLETE (2)'
Dec  4 13:31:45 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:45 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:45 shannah ipw2100: U ipw2100_wx_set_scan Initiating scan...
Dec  4 13:31:45 shannah ipw2100: U ipw2100_set_scan_options enter
Dec  4 13:31:45 shannah ipw2100: U ipw2100_set_scan_options setting scan options
Dec  4 13:31:45 shannah ipw2100: U ipw2100_hw_send_command Sending SET_SCAN_OPTIONS command (#46), 8 bytes
Dec  4 13:31:45 shannah 00000000 00 00 00 00 00 00 00 00                            ........         
Dec  4 13:31:45 shannah ipw2100: I isr_rx_complete_command Command completed 'SET_SCAN_OPTIONS (46)'
Dec  4 13:31:45 shannah ipw2100: U ipw2100_set_scan_options SET_SCAN_OPTIONS 0x0000
Dec  4 13:31:45 shannah ipw2100: U ipw2100_start_scan START_SCAN
Dec  4 13:31:45 shannah ipw2100: U ipw2100_start_scan Scan requested while already in scan...
Dec  4 13:31:45 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:45 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:45 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:45 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:45 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCAN_COMPLETE
Dec  4 13:31:45 shannah ipw2100: I isr_scan_complete scan complete
Dec  4 13:31:45 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:45 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:45 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:45 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:45 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:45 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:46 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCAN_COMPLETE
Dec  4 13:31:46 shannah ipw2100: I isr_scan_complete scan complete
Dec  4 13:31:46 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:46 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:46 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:46 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:46 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:46 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:46 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCAN_COMPLETE
Dec  4 13:31:46 shannah ipw2100: I isr_scan_complete scan complete
Dec  4 13:31:46 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:46 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:46 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:46 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:46 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:46 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:46 shannah ipw2100: U ipw2100_wx_set_scan Initiating scan...
Dec  4 13:31:46 shannah ipw2100: U ipw2100_set_scan_options enter
Dec  4 13:31:46 shannah ipw2100: U ipw2100_set_scan_options setting scan options
Dec  4 13:31:46 shannah ipw2100: U ipw2100_hw_send_command Sending SET_SCAN_OPTIONS command (#46), 8 bytes
Dec  4 13:31:46 shannah 00000000 00 00 00 00 00 00 00 00                            ........         
Dec  4 13:31:46 shannah ipw2100: I isr_rx_complete_command Command completed 'SET_SCAN_OPTIONS (46)'
Dec  4 13:31:46 shannah ipw2100: U ipw2100_set_scan_options SET_SCAN_OPTIONS 0x0000
Dec  4 13:31:46 shannah ipw2100: U ipw2100_start_scan START_SCAN
Dec  4 13:31:46 shannah ipw2100: U ipw2100_start_scan Scan requested while already in scan...
Dec  4 13:31:46 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCAN_COMPLETE
Dec  4 13:31:46 shannah ipw2100: I isr_scan_complete scan complete
Dec  4 13:31:46 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:46 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:47 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:47 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:47 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:47 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:47 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCAN_COMPLETE
Dec  4 13:31:47 shannah ipw2100: I isr_scan_complete scan complete
Dec  4 13:31:47 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:47 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:47 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:47 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:47 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:47 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:47 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCAN_COMPLETE
Dec  4 13:31:47 shannah ipw2100: I isr_scan_complete scan complete
Dec  4 13:31:47 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:47 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:47 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:47 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:48 shannah ipw2100: U ipw2100_disable_adapter CARD_DISABLE
Dec  4 13:31:48 shannah ipw2100: U ipw2100_hw_send_command Sending CARD_DISABLE command (#44), 0 bytes
Dec  4 13:31:48 shannah ipw2100: I isr_rx_complete_command Command completed 'CARD_DISABLE (44)'
Dec  4 13:31:48 shannah ipw2100: I isr_status_change Status change: IPW_STATE_DISABLED
Dec  4 13:31:48 shannah ipw2100: U ipw2100_disable_adapter TODO: implement scan state machine
Dec  4 13:31:48 shannah ipw2100: U ipw2100_set_security_information SET_SECURITY_INFORMATION: auth:0 cipher:0x01 (level 0)
Dec  4 13:31:48 shannah ipw2100: U ipw2100_hw_send_command Sending SET_SECURITY_INFORMATION command (#67), 9 bytes
Dec  4 13:31:48 shannah 00000000 01 00 00 00 00 00 00 00  00                        ........ .       
Dec  4 13:31:48 shannah ipw2100: I isr_rx_complete_command Command completed 'SET_SECURITY_INFORMATION (67)'
Dec  4 13:31:48 shannah ipw2100: U ipw2100_set_wep_flags WEP_FLAGS: flags = 0x00000000
Dec  4 13:31:48 shannah ipw2100: U ipw2100_hw_send_command Sending WEP_FLAGS command (#26), 4 bytes
Dec  4 13:31:48 shannah 00000000 00 00 00 00                                        ....             
Dec  4 13:31:48 shannah ipw2100: I isr_rx_complete_command Command completed 'WEP_FLAGS (26)'
Dec  4 13:31:48 shannah ipw2100: U ipw2100_enable_adapter HOST_COMPLETE
Dec  4 13:31:48 shannah ipw2100: U ipw2100_hw_send_command Sending HOST_COMPLETE command (#2), 0 bytes
Dec  4 13:31:48 shannah ipw2100: I isr_rx_complete_command Command completed 'HOST_COMPLETE (2)'
Dec  4 13:31:48 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:48 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:48 shannah ipw2100: U ipw2100_disable_adapter CARD_DISABLE
Dec  4 13:31:48 shannah ipw2100: U ipw2100_hw_send_command Sending CARD_DISABLE command (#44), 0 bytes
Dec  4 13:31:48 shannah ipw2100: I isr_rx_complete_command Command completed 'CARD_DISABLE (44)'
Dec  4 13:31:48 shannah ipw2100: I isr_status_change Status change: IPW_STATE_DISABLED
Dec  4 13:31:48 shannah ipw2100: U ipw2100_disable_adapter TODO: implement scan state machine
Dec  4 13:31:48 shannah ipw2100: U ipw2100_set_security_information SET_SECURITY_INFORMATION: auth:0 cipher:0x22 (level 1)
Dec  4 13:31:48 shannah ipw2100: U ipw2100_hw_send_command Sending SET_SECURITY_INFORMATION command (#67), 9 bytes
Dec  4 13:31:48 shannah 00000000 22 00 00 00 00 00 00 00  00                        "....... .       
Dec  4 13:31:48 shannah ipw2100: I isr_rx_complete_command Command completed 'SET_SECURITY_INFORMATION (67)'
Dec  4 13:31:48 shannah ipw2100: U ipw2100_set_key_index WEP_KEY_INDEX: index = 0
Dec  4 13:31:48 shannah ipw2100: U ipw2100_hw_send_command Sending WEP_KEY_INDEX command (#25), 4 bytes
Dec  4 13:31:48 shannah 00000000 00 00 00 00                                        ....             
Dec  4 13:31:48 shannah ipw2100: I isr_rx_complete_command Command completed 'WEP_KEY_INDEX (25)'
Dec  4 13:31:48 shannah ipw2100: U ipw2100_set_wep_flags WEP_FLAGS: flags = 0x00000008
Dec  4 13:31:48 shannah ipw2100: U ipw2100_hw_send_command Sending WEP_FLAGS command (#26), 4 bytes
Dec  4 13:31:48 shannah 00000000 08 00 00 00                                        ....             
Dec  4 13:31:48 shannah ipw2100: I isr_rx_complete_command Command completed 'WEP_FLAGS (26)'
Dec  4 13:31:48 shannah ipw2100: U ipw2100_enable_adapter HOST_COMPLETE
Dec  4 13:31:48 shannah ipw2100: U ipw2100_hw_send_command Sending HOST_COMPLETE command (#2), 0 bytes
Dec  4 13:31:48 shannah ipw2100: I isr_rx_complete_command Command completed 'HOST_COMPLETE (2)'
Dec  4 13:31:48 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:48 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:48 shannah ipw2100: U ipw2100_wx_set_mode SET Mode -> 2 
Dec  4 13:31:48 shannah ipw2100: U ipw2100_set_wpa_ie SET_WPA_IE
Dec  4 13:31:48 shannah ipw2100: U ipw2100_disable_adapter CARD_DISABLE
Dec  4 13:31:48 shannah ipw2100: U ipw2100_hw_send_command Sending CARD_DISABLE command (#44), 0 bytes
Dec  4 13:31:48 shannah ipw2100: I isr_rx_complete_command Command completed 'CARD_DISABLE (44)'
Dec  4 13:31:48 shannah ipw2100: I isr_status_change Status change: IPW_STATE_DISABLED
Dec  4 13:31:48 shannah ipw2100: U ipw2100_disable_adapter TODO: implement scan state machine
Dec  4 13:31:48 shannah ipw2100: U ipw2100_hw_send_command Sending SET_WPA_ASS_IE command (#69), 400 bytes
Dec  4 13:31:48 shannah 00000000 00 00 00 00 BE D5 A9 E1  F0 C6 D4 DD 18 00 00 00   ........ ........
Dec  4 13:31:48 shannah 00000010 DD 16 00 50 F2 01 01 00  00 50 F2 02 01 00 00 50   ...P.... .P.....P
Dec  4 13:31:48 shannah 00000020 F2 02 01 00 00 50 F2 02  80 01 00 00 04 00 00 00   .....P.. ........
Dec  4 13:31:48 shannah 00000030 01 DA A9 E1 F0 C6 D4 DD  00 00 00 00 00 00 00 00   ........ ........
Dec  4 13:31:48 shannah 00000040 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   ........ ........
Dec  4 13:31:48 shannah 00000050 00 00 00 00 AC 5D 91 D3  FF FF FF FF C0 BB 39 C0   .....].. ......9.
Dec  4 13:31:48 shannah 00000060 00 00 00 00 20 00 00 00  00 00 00 20 F0 C6 D4 DD   .... ... ... ....
Dec  4 13:31:48 shannah 00000070 A0 9B BE 1E 32 C8 08 00  C8 A9 49 83 C0 A3 37 DF   ....2... ..I...7.
Dec  4 13:31:48 shannah 00000080 F0 A0 32 DF F0 A0 32 DF  A6 AF 07 27 94 5D 91 D3   ..2...2. ...'.]..
Dec  4 13:31:48 shannah 00000090 2D 49 11 C0 F0 A0 32 DF  50 DF 46 C0 32 02 00 00   -I....2. P.F.2...
Dec  4 13:31:48 shannah 000000A0 F0 A0 32 DF A8 5D 91 D3  01 00 00 00 B4 5D 91 D3   ..2..].. .....]..
Dec  4 13:31:48 shannah 000000B0 96 00 00 00 F0 A0 32 DF  20 DF 46 C0 01 00 00 00   ......2.  .F.....
Dec  4 13:31:48 shannah 000000C0 96 00 00 00 00 00 00 00  CC 81 3E C0 D8 5D 91 D3   ........ ..>..]..
Dec  4 13:31:48 shannah 000000D0 D8 52 11 C0 F0 A0 32 DF  01 00 00 00 00 00 00 00   .R....2. ........
Dec  4 13:31:48 shannah 000000E0 00 00 00 00 00 00 00 00  82 02 00 00 EF EC 46 C0   ........ ......F.
Dec  4 13:31:48 shannah 000000F0 86 02 00 00 82 02 00 00  00 00 00 00 92 02 00 00   ........ ........
Dec  4 13:31:48 shannah 00000100 00 CB 51 DF 10 5E 91 D3  92 02 00 00 00 AC 40 C0   ..Q..^.. ......@.
Dec  4 13:31:48 shannah 00000110 03 00 00 00 01 00 00 00  00 00 00 00 00 00 00 00   ........ ........
Dec  4 13:31:48 shannah 00000120 00 D0 F4 DC 00 00 00 00  2C 5E 91 D3 F6 8A 35 C0   ........ ,^....5.
Dec  4 13:31:48 shannah 00000130 00 00 00 00 2C 00 00 00  EC F0 FF FF 20 00 00 00   ....,... .... ...
Dec  4 13:31:48 shannah 00000140 00 CB 51 DF 00 9E F5 DF  00 00 00 00 01 00 00 00   ..Q..... ........
Dec  4 13:31:48 shannah 00000150 00 00 00 00 00 00 00 00  01 00 00 00 20 00 00 00   ........ .... ...
Dec  4 13:31:48 shannah 00000160 00 CB 51 DF 00 00 00 00  E8 0F 00 00 0C 00 00 00   ..Q..... ........
Dec  4 13:31:48 shannah 00000170 0C 00 00 00 74 8B 25 1F  9C C8 08 00 C0 F0 F6 DF   ....t.%. ........
Dec  4 13:31:48 shannah 00000180 60 C2 D4 DD 82 02 00 00  79 14 00 00 08 5F 03 DD   `....... y...._..
Dec  4 13:31:48 shannah ipw2100: I isr_rx_complete_command Command completed 'SET_WPA_ASS_IE (69)'
Dec  4 13:31:48 shannah ipw2100: U ipw2100_enable_adapter HOST_COMPLETE
Dec  4 13:31:48 shannah ipw2100: U ipw2100_hw_send_command Sending HOST_COMPLETE command (#2), 0 bytes
Dec  4 13:31:48 shannah ipw2100: I isr_rx_complete_command Command completed 'HOST_COMPLETE (2)'
Dec  4 13:31:48 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:48 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:48 shannah ipw2100: U ipw2100_wx_set_essid ESSID set to current ESSID.
Dec  4 13:31:48 shannah ipw2100: U ipw2100_set_mandatory_bssid MANDATORY_BSSID: 00:09:5B:CB:30:BA
Dec  4 13:31:48 shannah ipw2100: U ipw2100_disable_adapter CARD_DISABLE
Dec  4 13:31:48 shannah ipw2100: U ipw2100_hw_send_command Sending CARD_DISABLE command (#44), 0 bytes
Dec  4 13:31:48 shannah ipw2100: I isr_rx_complete_command Command completed 'CARD_DISABLE (44)'
Dec  4 13:31:48 shannah ipw2100: I isr_status_change Status change: IPW_STATE_DISABLED
Dec  4 13:31:48 shannah ipw2100: U ipw2100_disable_adapter TODO: implement scan state machine
Dec  4 13:31:48 shannah ipw2100: U ipw2100_hw_send_command Sending MANDATORY_BSSID command (#9), 6 bytes
Dec  4 13:31:48 shannah 00000000 00 09 5B CB 30 BA                                  ..[.0.           
Dec  4 13:31:48 shannah ipw2100: I isr_rx_complete_command Command completed 'MANDATORY_BSSID (9)'
Dec  4 13:31:48 shannah ipw2100: U ipw2100_enable_adapter HOST_COMPLETE
Dec  4 13:31:48 shannah ipw2100: U ipw2100_hw_send_command Sending HOST_COMPLETE command (#2), 0 bytes
Dec  4 13:31:48 shannah ipw2100: I isr_rx_complete_command Command completed 'HOST_COMPLETE (2)'
Dec  4 13:31:48 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:48 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:48 shannah ipw2100: U ipw2100_wx_set_wap SET BSSID -> 00:09:5B:CB:30:BA
Dec  4 13:31:48 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:48 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:48 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:48 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:48 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCAN_COMPLETE
Dec  4 13:31:48 shannah ipw2100: I isr_scan_complete scan complete
Dec  4 13:31:48 shannah ipw2100: I isr_status_change Status change: IPW_STATE_ASSOCIATED
Dec  4 13:31:48 shannah ipw2100: I isr_indicate_associated eth0: Associated with 'subbuwifiBG' at 11Mbps, channel 11 (BSSID=00:09:5b:cb:30:ba)
Dec  4 13:31:48 shannah ipw2100: I isr_rx Dropping packet while not associated.
Dec  4 13:31:48 shannah ipw2100: U ipw2100_wx_event_work enter
Dec  4 13:31:48 shannah ipw2100: U ipw2100_wx_get_wap Getting WAP BSSID: 00:09:5b:cb:30:ba
Dec  4 13:31:50 shannah ipw2100: U ipw2100_wx_get_essid Getting essid: 'subbuwifiBG'
Dec  4 13:31:50 shannah ipw2100: U ipw2100_wx_get_wap Getting WAP BSSID: 00:09:5b:cb:30:ba
Dec  4 13:31:50 shannah ipw2100: I isr_rx eth0: Non consumed packet:
Dec  4 13:31:50 shannah 00000000 08 42 D5 00 00 04 23 51  CF 8F 00 09 5B CB 30 BA   .B....#Q ....[.0.
Dec  4 13:31:50 shannah 00000010 00 09 5B CB 30 BA A0 04  00 20 00 20 00 00 00 00   ..[.0... . . ....
Dec  4 13:31:50 shannah 00000020 7D FB CC DB 62 11 55 68  1E D3 0F 31 C8 71 C8 26   }...b.Uh ...1.q.&
Dec  4 13:31:50 shannah 00000030 46 F3 01 F0 46 79 06 3D  1A F1 AA D1 51 21 4B 04   F...Fy.= ....Q!K.
Dec  4 13:31:50 shannah 00000040 89 37 1F 6F 85 F0 93 76  34 53 EB 09 20 CF 93 73   .7.o...v 4S.. ..s
Dec  4 13:31:50 shannah 00000050 8C 1B 64 55 9B 8D 9F 14  61 51 99 8A AD 5A 2D ED   ..dU.... aQ...Z-.
Dec  4 13:31:50 shannah 00000060 8B BD 08 E0 76 A7 10 5E  33 0E D3 D4 9E 41 90 22   ....v..^ 3....A."
Dec  4 13:31:50 shannah 00000070 4C 6A 99 BA 60 8D 98 ED  04 A1 75 2E 6A F2 52 5A   Lj..`... ..u.j.RZ
Dec  4 13:31:50 shannah 00000080 06 98 65 77 A7 BC 1F 24  BA FC 8F 68 34 61 0D D4   ..ew...$ ...h4a..
Dec  4 13:31:50 shannah 00000090 16 8E 27 E5 D2 D0 10 D8  22 DE 6C 31 3D EF AA FE   ..'..... ".l1=...
Dec  4 13:31:50 shannah 000000A0 B0 BA 1E AB AD F0 BE FE  9D 67 55 3F 4B 44 95 07   ........ .gU?KD..
Dec  4 13:31:50 shannah 000000B0 60 78 8A A9 CB 63 60                               `x...c`          
Dec  4 13:31:52 shannah ipw2100: I isr_rx eth0: Non consumed packet:
Dec  4 13:31:52 shannah 00000000 08 42 D5 00 00 04 23 51  CF 8F 00 09 5B CB 30 BA   .B....#Q ....[.0.
Dec  4 13:31:52 shannah 00000010 00 09 5B CB 30 BA E0 05  00 20 01 20 00 00 00 00   ..[.0... . . ....
Dec  4 13:31:52 shannah 00000020 B6 E3 FE 91 82 08 DC 6F  B8 C7 BA 18 D2 FE CA 1A   .......o ........
Dec  4 13:31:52 shannah 00000030 3C E9 5F 40 FB 5C 0A 6E  5A AB 1E 58 75 68 5D 18   <._@.\.n Z..Xuh].
Dec  4 13:31:52 shannah 00000040 83 B1 0C F6 76 97 07 85  17 A8 69 EC F1 66 C3 9F   ....v... ..i..f..
Dec  4 13:31:52 shannah 00000050 F9 4C 19 A5 1B CC 99 41  25 C8 13 04 27 11 20 33   .L.....A %...'. 3
Dec  4 13:31:52 shannah 00000060 51 11 E1 66 DE 34 11 08  57 E3 4A D6 DD 4C 93 F6   Q..f.4.. W.J..L..
Dec  4 13:31:52 shannah 00000070 0B 82 48 BF 41 C3 EC 5D  FE 14 8A 54 CE 48 5F 7D   ..H.A..] ...T.H_}
Dec  4 13:31:52 shannah 00000080 1E A7 D2 19 CE 26 25 8E  59 87 9B 2E 77 F0 BC F2   .....&%. Y...w...
Dec  4 13:31:52 shannah 00000090 7D 80 B4 1F 61 E3 6C E2  D4 65 21 2E 1B D6 83 13   }...a.l. .e!.....
Dec  4 13:31:52 shannah 000000A0 76 D5 41 C6 A2 D0 F2 02  9B 29 4F 0F 9B 9C 74 64   v.A..... .)O...td
Dec  4 13:31:52 shannah 000000B0 9E E4 31 30 1D 3A 7D                               ..10.:}          
Dec  4 13:31:54 shannah ipw2100: I isr_rx eth0: Non consumed packet:
Dec  4 13:31:54 shannah 00000000 08 42 D5 00 00 04 23 51  CF 8F 00 09 5B CB 30 BA   .B....#Q ....[.0.
Dec  4 13:31:54 shannah 00000010 00 09 5B CB 30 BA 30 07  00 20 02 20 00 00 00 00   ..[.0.0. . . ....
Dec  4 13:31:54 shannah 00000020 06 91 F1 E1 09 45 21 8D  E3 BF B1 1F 43 37 39 61   .....E!. ....C79a
Dec  4 13:31:54 shannah 00000030 D2 0B C0 4D 7C 75 08 20  D4 19 19 CC 4F ED 23 01   ...M|u.  ....O.#.
Dec  4 13:31:54 shannah 00000040 30 08 7A 20 FB 68 9F 82  C4 6D A7 67 7C 9E 76 72   0.z .h.. .m.g|.vr
Dec  4 13:31:54 shannah 00000050 53 9C EC 67 97 00 64 B2  9E 6C B9 51 72 03 FE A0   S..g..d. .l.Qr...
Dec  4 13:31:54 shannah 00000060 BB F0 38 2E 17 74 89 20  B1 67 DC B7 AC EC 4F 27   ..8..t.  .g....O'
Dec  4 13:31:54 shannah 00000070 81 3A 4C F5 57 8F D8 BB  D4 AB 21 E5 C3 CE 08 BE   .:L.W... ..!.....
Dec  4 13:31:54 shannah 00000080 9D FA D6 DE F9 1D 30 DB  EB 5F F7 6A F6 22 B3 08   ......0. ._.j."..
Dec  4 13:31:54 shannah 00000090 25 6A 24 3F 5B 8E 6D B9  40 95 3B BA 10 9D 7B 4E   %j$?[.m. @.;...{N
Dec  4 13:31:54 shannah 000000A0 E5 32 CD 82 91 AF 17 73  3A 81 0C C1 F0 E2 17 E4   .2.....s :.......
Dec  4 13:31:54 shannah 000000B0 AB 93 82 B3 60 C1 FA                               ....`..          
Dec  4 13:31:56 shannah ipw2100: I isr_rx eth0: Non consumed packet:
Dec  4 13:31:56 shannah 00000000 08 42 D5 00 00 04 23 51  CF 8F 00 09 5B CB 30 BA   .B....#Q ....[.0.
Dec  4 13:31:56 shannah 00000010 00 09 5B CB 30 BA 70 08  00 20 03 20 00 00 00 00   ..[.0.p. . . ....
Dec  4 13:31:56 shannah 00000020 2A 43 1B D0 A6 4B 00 C2  AD 44 22 80 62 5C F4 EC   *C...K.. .D".b\..
Dec  4 13:31:56 shannah 00000030 30 F2 A7 D3 28 5B 56 7E  BC 85 71 1B BD 44 BF E4   0...([V~ ..q..D..
Dec  4 13:31:56 shannah 00000040 B3 FE 6A 49 72 9D 41 1B  CD 6E 5A 67 B2 B0 1C 05   ..jIr.A. .nZg....
Dec  4 13:31:56 shannah 00000050 1A A7 0E 76 1C 8E 98 D8  7F 86 F0 6E 3B 5E AD 7F   ...v.... ...n;^..
Dec  4 13:31:56 shannah 00000060 5F E1 69 0A B5 AE 7C 94  69 05 B5 6F B0 AD 9C DF   _.i...|. i..o....
Dec  4 13:31:56 shannah 00000070 8A 86 3B FB 53 AC 2D F9  E3 CE D7 9F 7F 32 54 9B   ..;.S.-. .....2T.
Dec  4 13:31:56 shannah 00000080 2C 41 FF 15 52 9E ED 70  17 E9 65 49 8A 4F AD FE   ,A..R..p ..eI.O..
Dec  4 13:31:56 shannah 00000090 53 30 E5 FD FC 00 92 70  F3 40 6B 51 CF 23 47 77   S0.....p .@kQ.#Gw
Dec  4 13:31:56 shannah 000000A0 3C B8 BE D3 5E F9 70 42  70 5D E4 23 05 73 FB 49   <...^.pB p].#.s.I
Dec  4 13:31:56 shannah 000000B0 DE 22 13 7E 2B F0 A4                               .".~+..          
Dec  4 13:31:58 shannah ipw2100: I isr_status_change Status change: IPW_STATE_ASSN_LOST
Dec  4 13:31:58 shannah ipw2100: I isr_indicate_association_lost disassociated: 'subbuwifiBG' 00:09:5b:cb:30:ba 
Dec  4 13:31:58 shannah ipw2100: U ipw2100_wx_event_work enter
Dec  4 13:31:58 shannah ipw2100: U ipw2100_wx_event_work Configuring ESSID
Dec  4 13:31:58 shannah ipw2100: U ipw2100_set_essid SSID: 'subbuwifiBG'
Dec  4 13:31:58 shannah ipw2100: U ipw2100_disable_adapter CARD_DISABLE
Dec  4 13:31:58 shannah ipw2100: U ipw2100_hw_send_command Sending CARD_DISABLE command (#44), 0 bytes
Dec  4 13:31:58 shannah ipw2100: I isr_rx_complete_command Command completed 'CARD_DISABLE (44)'
Dec  4 13:31:58 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:58 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:58 shannah ipw2100: I isr_status_change Status change: IPW_STATE_DISABLED
Dec  4 13:31:58 shannah ipw2100: U ipw2100_disable_adapter TODO: implement scan state machine
Dec  4 13:31:58 shannah ipw2100: U ipw2100_hw_send_command Sending SSID command (#8), 11 bytes
Dec  4 13:31:58 shannah 00000000 73 75 62 62 75 77 69 66  69 42 47                  subbuwif iBG     
Dec  4 13:31:58 shannah ipw2100: I isr_rx_complete_command Command completed 'SSID (8)'
Dec  4 13:31:58 shannah ipw2100: U ipw2100_enable_adapter HOST_COMPLETE
Dec  4 13:31:58 shannah ipw2100: U ipw2100_hw_send_command Sending HOST_COMPLETE command (#2), 0 bytes
Dec  4 13:31:58 shannah ipw2100: I isr_rx_complete_command Command completed 'HOST_COMPLETE (2)'
Dec  4 13:31:58 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:58 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:58 shannah ipw2100: U ipw2100_disable_adapter CARD_DISABLE
Dec  4 13:31:58 shannah ipw2100: U ipw2100_hw_send_command Sending CARD_DISABLE command (#44), 0 bytes
Dec  4 13:31:58 shannah ipw2100: I isr_rx_complete_command Command completed 'CARD_DISABLE (44)'
Dec  4 13:31:58 shannah ipw2100: I isr_status_change Status change: IPW_STATE_DISABLED
Dec  4 13:31:58 shannah ipw2100: U ipw2100_disable_adapter TODO: implement scan state machine
Dec  4 13:31:58 shannah ipw2100: U ipw2100_set_security_information SET_SECURITY_INFORMATION: auth:0 cipher:0x01 (level 0)
Dec  4 13:31:58 shannah ipw2100: U ipw2100_hw_send_command Sending SET_SECURITY_INFORMATION command (#67), 9 bytes
Dec  4 13:31:58 shannah 00000000 01 00 00 00 00 00 00 00  00                        ........ .       
Dec  4 13:31:58 shannah ipw2100: I isr_rx_complete_command Command completed 'SET_SECURITY_INFORMATION (67)'
Dec  4 13:31:58 shannah ipw2100: U ipw2100_set_wep_flags WEP_FLAGS: flags = 0x00000000
Dec  4 13:31:58 shannah ipw2100: U ipw2100_hw_send_command Sending WEP_FLAGS command (#26), 4 bytes
Dec  4 13:31:58 shannah 00000000 00 00 00 00                                        ....             
Dec  4 13:31:58 shannah ipw2100: I isr_rx_complete_command Command completed 'WEP_FLAGS (26)'
Dec  4 13:31:58 shannah ipw2100: U ipw2100_enable_adapter HOST_COMPLETE
Dec  4 13:31:58 shannah ipw2100: U ipw2100_hw_send_command Sending HOST_COMPLETE command (#2), 0 bytes
Dec  4 13:31:58 shannah ipw2100: I isr_rx_complete_command Command completed 'HOST_COMPLETE (2)'
Dec  4 13:31:58 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:58 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:58 shannah ipw2100: U ipw2100_disable_adapter CARD_DISABLE
Dec  4 13:31:58 shannah ipw2100: U ipw2100_hw_send_command Sending CARD_DISABLE command (#44), 0 bytes
Dec  4 13:31:58 shannah ipw2100: I isr_rx_complete_command Command completed 'CARD_DISABLE (44)'
Dec  4 13:31:58 shannah ipw2100: I isr_status_change Status change: IPW_STATE_DISABLED
Dec  4 13:31:58 shannah ipw2100: U ipw2100_disable_adapter TODO: implement scan state machine
Dec  4 13:31:58 shannah ipw2100: U ipw2100_set_security_information SET_SECURITY_INFORMATION: auth:0 cipher:0x01 (level 0)
Dec  4 13:31:58 shannah ipw2100: U ipw2100_hw_send_command Sending SET_SECURITY_INFORMATION command (#67), 9 bytes
Dec  4 13:31:58 shannah 00000000 01 00 00 00 00 00 00 00  00                        ........ .       
Dec  4 13:31:58 shannah ipw2100: I isr_rx_complete_command Command completed 'SET_SECURITY_INFORMATION (67)'
Dec  4 13:31:58 shannah ipw2100: U ipw2100_set_wep_flags WEP_FLAGS: flags = 0x00000000
Dec  4 13:31:58 shannah ipw2100: U ipw2100_hw_send_command Sending WEP_FLAGS command (#26), 4 bytes
Dec  4 13:31:58 shannah 00000000 00 00 00 00                                        ....             
Dec  4 13:31:58 shannah ipw2100: I isr_rx_complete_command Command completed 'WEP_FLAGS (26)'
Dec  4 13:31:58 shannah ipw2100: U ipw2100_enable_adapter HOST_COMPLETE
Dec  4 13:31:58 shannah ipw2100: U ipw2100_hw_send_command Sending HOST_COMPLETE command (#2), 0 bytes
Dec  4 13:31:58 shannah ipw2100: I isr_rx_complete_command Command completed 'HOST_COMPLETE (2)'
Dec  4 13:31:58 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:58 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:58 shannah ipw2100: U ipw2100_disable_adapter CARD_DISABLE
Dec  4 13:31:58 shannah ipw2100: U ipw2100_hw_send_command Sending CARD_DISABLE command (#44), 0 bytes
Dec  4 13:31:58 shannah ipw2100: I isr_rx_complete_command Command completed 'CARD_DISABLE (44)'
Dec  4 13:31:58 shannah ipw2100: I isr_status_change Status change: IPW_STATE_DISABLED
Dec  4 13:31:58 shannah ipw2100: U ipw2100_disable_adapter TODO: implement scan state machine
Dec  4 13:31:58 shannah ipw2100: U ipw2100_set_security_information SET_SECURITY_INFORMATION: auth:0 cipher:0x01 (level 0)
Dec  4 13:31:58 shannah ipw2100: U ipw2100_hw_send_command Sending SET_SECURITY_INFORMATION command (#67), 9 bytes
Dec  4 13:31:58 shannah 00000000 01 00 00 00 00 00 00 00  00                        ........ .       
Dec  4 13:31:58 shannah ipw2100: I isr_rx_complete_command Command completed 'SET_SECURITY_INFORMATION (67)'
Dec  4 13:31:58 shannah ipw2100: U ipw2100_set_wep_flags WEP_FLAGS: flags = 0x00000000
Dec  4 13:31:58 shannah ipw2100: U ipw2100_hw_send_command Sending WEP_FLAGS command (#26), 4 bytes
Dec  4 13:31:58 shannah 00000000 00 00 00 00                                        ....             
Dec  4 13:31:58 shannah ipw2100: I isr_rx_complete_command Command completed 'WEP_FLAGS (26)'
Dec  4 13:31:58 shannah ipw2100: U ipw2100_enable_adapter HOST_COMPLETE
Dec  4 13:31:58 shannah ipw2100: U ipw2100_hw_send_command Sending HOST_COMPLETE command (#2), 0 bytes
Dec  4 13:31:58 shannah ipw2100: I isr_rx_complete_command Command completed 'HOST_COMPLETE (2)'
Dec  4 13:31:58 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:58 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:58 shannah ipw2100: U ipw2100_disable_adapter CARD_DISABLE
Dec  4 13:31:58 shannah ipw2100: U ipw2100_hw_send_command Sending CARD_DISABLE command (#44), 0 bytes
Dec  4 13:31:58 shannah ipw2100: I isr_rx_complete_command Command completed 'CARD_DISABLE (44)'
Dec  4 13:31:58 shannah ipw2100: I isr_status_change Status change: IPW_STATE_DISABLED
Dec  4 13:31:58 shannah ipw2100: U ipw2100_disable_adapter TODO: implement scan state machine
Dec  4 13:31:58 shannah ipw2100: U ipw2100_set_security_information SET_SECURITY_INFORMATION: auth:0 cipher:0x01 (level 0)
Dec  4 13:31:58 shannah ipw2100: U ipw2100_hw_send_command Sending SET_SECURITY_INFORMATION command (#67), 9 bytes
Dec  4 13:31:58 shannah 00000000 01 00 00 00 00 00 00 00  00                        ........ .       
Dec  4 13:31:58 shannah ipw2100: I isr_rx_complete_command Command completed 'SET_SECURITY_INFORMATION (67)'
Dec  4 13:31:58 shannah ipw2100: U ipw2100_set_wep_flags WEP_FLAGS: flags = 0x00000000
Dec  4 13:31:58 shannah ipw2100: U ipw2100_hw_send_command Sending WEP_FLAGS command (#26), 4 bytes
Dec  4 13:31:58 shannah 00000000 00 00 00 00                                        ....             
Dec  4 13:31:58 shannah ipw2100: I isr_rx_complete_command Command completed 'WEP_FLAGS (26)'
Dec  4 13:31:58 shannah ipw2100: U ipw2100_enable_adapter HOST_COMPLETE
Dec  4 13:31:58 shannah ipw2100: U ipw2100_hw_send_command Sending HOST_COMPLETE command (#2), 0 bytes
Dec  4 13:31:58 shannah ipw2100: I isr_rx_complete_command Command completed 'HOST_COMPLETE (2)'
Dec  4 13:31:58 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:58 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:58 shannah ipw2100: U ipw2100_disable_adapter CARD_DISABLE
Dec  4 13:31:58 shannah ipw2100: U ipw2100_hw_send_command Sending CARD_DISABLE command (#44), 0 bytes
Dec  4 13:31:58 shannah ipw2100: I isr_rx_complete_command Command completed 'CARD_DISABLE (44)'
Dec  4 13:31:58 shannah ipw2100: I isr_status_change Status change: IPW_STATE_DISABLED
Dec  4 13:31:58 shannah ipw2100: U ipw2100_disable_adapter TODO: implement scan state machine
Dec  4 13:31:58 shannah ipw2100: U ipw2100_set_security_information SET_SECURITY_INFORMATION: auth:0 cipher:0x01 (level 0)
Dec  4 13:31:58 shannah ipw2100: U ipw2100_hw_send_command Sending SET_SECURITY_INFORMATION command (#67), 9 bytes
Dec  4 13:31:58 shannah 00000000 01 00 00 00 00 00 00 00  00                        ........ .       
Dec  4 13:31:58 shannah ipw2100: I isr_rx_complete_command Command completed 'SET_SECURITY_INFORMATION (67)'
Dec  4 13:31:58 shannah ipw2100: U ipw2100_set_wep_flags WEP_FLAGS: flags = 0x00000000
Dec  4 13:31:58 shannah ipw2100: U ipw2100_hw_send_command Sending WEP_FLAGS command (#26), 4 bytes
Dec  4 13:31:58 shannah 00000000 00 00 00 00                                        ....             
Dec  4 13:31:58 shannah ipw2100: I isr_rx_complete_command Command completed 'WEP_FLAGS (26)'
Dec  4 13:31:59 shannah ipw2100: U ipw2100_enable_adapter HOST_COMPLETE
Dec  4 13:31:59 shannah ipw2100: U ipw2100_hw_send_command Sending HOST_COMPLETE command (#2), 0 bytes
Dec  4 13:31:59 shannah ipw2100: I isr_rx_complete_command Command completed 'HOST_COMPLETE (2)'
Dec  4 13:31:59 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:59 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:59 shannah ipw2100: U ipw2100_wx_set_scan Initiating scan...
Dec  4 13:31:59 shannah ipw2100: U ipw2100_set_scan_options enter
Dec  4 13:31:59 shannah ipw2100: U ipw2100_set_scan_options setting scan options
Dec  4 13:31:59 shannah ipw2100: U ipw2100_hw_send_command Sending SET_SCAN_OPTIONS command (#46), 8 bytes
Dec  4 13:31:59 shannah 00000000 00 00 00 00 00 00 00 00                            ........         
Dec  4 13:31:59 shannah ipw2100: I isr_rx_complete_command Command completed 'SET_SCAN_OPTIONS (46)'
Dec  4 13:31:59 shannah ipw2100: U ipw2100_set_scan_options SET_SCAN_OPTIONS 0x0000
Dec  4 13:31:59 shannah ipw2100: U ipw2100_start_scan START_SCAN
Dec  4 13:31:59 shannah ipw2100: U ipw2100_start_scan Scan requested while already in scan...
Dec  4 13:31:59 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:59 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:59 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:59 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:59 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCAN_COMPLETE
Dec  4 13:31:59 shannah ipw2100: I isr_scan_complete scan complete
Dec  4 13:31:59 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:59 shannah ipw2100: I isr_indicate_scanning Scanning...
Dec  4 13:31:59 shannah ipw2100: I isr_status_change Status change: IPW_STATE_SCANNING
Dec  4 13:31:59 shannah ipw2100: I isr_indicate_scanning Scanning...


------=_Part_18005_23421961.1133705555364
Content-Type: application/octet-stream; name=.config
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.15-rc4
# Sun Dec  4 12:41:53 2005
#
CONFIG_X86_32=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
# CONFIG_IKCONFIG is not set
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_MODULE_SRCVERSION_ALL=y
# CONFIG_KMOD is not set

#
# Block layer
#
CONFIG_LBD=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUMM=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
# CONFIG_REGPARM is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_PHYSICAL_START=0x100000
# CONFIG_KEXEC is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_LEGACY is not set
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_HOTKEY=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
CONFIG_ACPI_IBM=m
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set
# CONFIG_ACPI_CONTAINER is not set

#
# APM (Advanced Power Management) BIOS Support
#

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_STAT_DETAILS=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPUFreq processor drivers
#
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_SPEEDSTEP_LIB is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_LEGACY_PROC=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
# CONFIG_INET_DIAG is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_IEEE80211=m
CONFIG_IEEE80211_DEBUG=y
CONFIG_IEEE80211_CRYPT_WEP=m
CONFIG_IEEE80211_CRYPT_CCMP=m
CONFIG_IEEE80211_CRYPT_TKIP=m

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=16
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_IDE_TASK_IOCTL=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA24XX is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=m

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
CONFIG_IEEE1394_OUI_DB=y
CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
CONFIG_IEEE1394_CONFIG_ROM_IP1394=y
CONFIG_IEEE1394_EXPORT_FULL_API=y

#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
# CONFIG_IEEE1394_VIDEO1394 is not set
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_SBP2_PHYS_DMA=y
# CONFIG_IEEE1394_ETH1394 is not set
# CONFIG_IEEE1394_DV1394 is not set
CONFIG_IEEE1394_RAWIO=m
# CONFIG_IEEE1394_CMP is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
CONFIG_PHYLIB=y

#
# MII PHY device drivers
#
CONFIG_MARVELL_PHY=m
CONFIG_DAVICOM_PHY=m
CONFIG_QSEMI_PHY=m
CONFIG_LXT_PHY=m
CONFIG_CICADA_PHY=m

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
CONFIG_B44=m
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=m
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
CONFIG_S2IO=m
# CONFIG_S2IO_NAPI is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_ARLAN is not set
# CONFIG_WAVELAN is not set

#
# Wireless 802.11b ISA/PCI cards support
#
CONFIG_IPW2100=m
# CONFIG_IPW2100_MONITOR is not set
CONFIG_IPW_DEBUG=y
# CONFIG_IPW2200 is not set
# CONFIG_AIRO is not set
# CONFIG_HERMES is not set
# CONFIG_ATMEL is not set

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
CONFIG_PRISM54=m
# CONFIG_HOSTAP is not set
CONFIG_NET_WIRELESS=y

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_WISTRON_BTNS is not set
# CONFIG_INPUT_UINPUT is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_ACPI=y
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=y
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=y
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
CONFIG_HANGCHECK_TIMER=y

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=m
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
# CONFIG_I2C_AMD756_S4882 is not set
CONFIG_I2C_AMD8111=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_I801=m
CONFIG_I2C_I810=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_ISA=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_PARPORT_LIGHT=m
CONFIG_I2C_PROSAVAGE=m
# CONFIG_I2C_SAVAGE4 is not set
CONFIG_SCx200_ACB=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_VOODOO3=m
CONFIG_I2C_PCA_ISA=m

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_RTC_X1205_I2C is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_FSCHER=m
CONFIG_SENSORS_FSCPOS=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia Capabilities Port drivers
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_MACMODES is not set
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
CONFIG_FB_RADEON=y
CONFIG_FB_RADEON_I2C=y
# CONFIG_FB_RADEON_DEBUG is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_CYBLA is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_GEODE is not set
CONFIG_FB_VIRTUAL=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
CONFIG_FONTS=y
# CONFIG_FONT_8x8 is not set
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_7x14 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_10x18 is not set

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set
CONFIG_SND_GENERIC_DRIVER=y

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
# CONFIG_SND_DUMMY is not set
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m

#
# ISA devices
#
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_DT019X is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=m
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_HDA_INTEL is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_OBSOLETE_OSS_USB_DRIVER is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Input Devices
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_ITMTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_ZD1201 is not set
CONFIG_USB_MON=y

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# SN Devices
#

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
# CONFIG_EXT2_FS_SECURITY is not set
# CONFIG_EXT2_FS_XIP is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_SECURITY is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y
# CONFIG_RELAYFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Instrumentation Support
#
# CONFIG_PROFILING is not set
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_EARLY_PRINTK=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_TEST=m

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC32=y
CONFIG_LIBCRC32C=y
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y

------=_Part_18005_23421961.1133705555364--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSHFPjt>; Tue, 6 Aug 2002 11:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293680AbSHFPjt>; Tue, 6 Aug 2002 11:39:49 -0400
Received: from air-2.osdl.org ([65.172.181.6]:21007 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S293203AbSHFPjs>;
	Tue, 6 Aug 2002 11:39:48 -0400
Date: Tue, 6 Aug 2002 08:41:13 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
cc: <abraham@2d3d.co.za>
Subject: Re: ethtool documentation
Message-ID: <Pine.LNX.4.33L2.0208060834030.10089-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Abraham vd Merwe <abraham@2d3d.co.za> wrote:
| What is the difference between the supported and advertising fields?
| What is MII? (as in the SUPPORTED_MII feature?).

MII:  (is this a serious question ?):
[from a National Semi. ethernet repeater design Application Note]
The Medium Independent Interface, as specified in the IEEE 802.3u/D5.3
standard, is designed to support the PHY/MAC interface.

| > ETHTOOL_GEEPROM
| > ETHTOOL_SEEPROM
| >
| >   Get/set EEPROM data.  These commands expect a 'struct ethtool_eeprom
| >   *'
| >   argument.  This struct has a magic number, an offset and length
| >   pair, and a
| >   data field.  If the offset+length are longer than the maximum size,
| >   the extra is silently ignored.
|
| Wouldn't it have been better to make this 'n character device which can
| be read from / written to just like a normal file (/dev/nvram-like
| interface) -
| that way applications can actually use unused eeprom space.

I wouldn't care for this.  There's nothing 'normal' about this
EEPROM space, and apps generally won't know where there might be
some 'unused eeprom space'.

-- 
~Randy


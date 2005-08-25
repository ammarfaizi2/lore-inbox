Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbVHYIDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbVHYIDR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 04:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbVHYIDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 04:03:17 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:59106 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S964865AbVHYIDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 04:03:16 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org
Subject: Any reason why %4.4x and not %04x?
Date: Thu, 25 Aug 2005 11:02:30 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508251102.30952.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

We have ~2k of printf format specs like this:

"%s: Transmit timed out, status %4.4x, PHY status %4.4x, resetting...\n"

IIRC %04x and %4.4x is totally equivalent. I even tested that
(test program is not here at the moment).

I have patches to save that 2k, if anybody knows about
any subtle differences between %04x and %4.4x please speak up.
--
vda


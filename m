Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132005AbRCVNAg>; Thu, 22 Mar 2001 08:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132011AbRCVNA1>; Thu, 22 Mar 2001 08:00:27 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:48905 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S132005AbRCVNAN>; Thu, 22 Mar 2001 08:00:13 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Thu, 22 Mar 2001 13:59:35 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.2.18: e100.c (SuSE 7.1): udelay() used in a wrong way?
Message-ID: <3ABA0537.18043.146E671@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From the source code of drivers/net/e100.c:

/****************************************************************************
 * Name:          Phy82562EHDelayMilliseconds
 *
 * Description:   Stalls execution for a specified number of milliseconds.
 *
 * Arguments:     Time - milliseconds to delay
 *
 * Returns:       Nothing
 *
 
************************************************************************
***/
void
Phy82562EHDelayMilliseconds(int Time)
{
    udelay(Time);
}


AFAIK, udelay() delays microseconds, not milliseconds.

Ulrich


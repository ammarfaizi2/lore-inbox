Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265494AbTL2Xcn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 18:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbTL2Xcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 18:32:42 -0500
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:58489 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265494AbTL2Xcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 18:32:41 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>, GCS <gcs@lsc.hu>
Subject: Re: 2.6.0-mm2
Date: Mon, 29 Dec 2003 18:32:35 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20031229013223.75c531ed.akpm@osdl.org> <20031229163955.GA20207@lsc.hu> <Pine.LNX.4.58.0312292008430.16514@student.dei.uc.pt>
In-Reply-To: <Pine.LNX.4.58.0312292008430.16514@student.dei.uc.pt>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312291832.35367.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 December 2003 03:10 pm, Marcos D. Marado Torres wrote:
> Well, as for me, I still can't get the "mouse tap" working with my Asus
> M3700N laptop.

Does this laptop have Synaptics hardware? And are you using native Synaptics
XFree driver or running with  psmouse_proto={bare|imps|exps}? Native absolute
mode -> relative PS/2 protocol translation that is done by mousedev does not
do taps. At all.

Dmitry

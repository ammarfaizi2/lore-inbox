Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272430AbTGZG1m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 02:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272429AbTGZG1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 02:27:42 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:22403
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272426AbTGZG1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 02:27:40 -0400
From: Con Kolivas <kernel@kolivas.org>
To: hajohe@imail.de, Hans-Joachim Hetscher <me@privacy.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.75 6PACK
Date: Sat, 26 Jul 2003 16:46:56 +1000
User-Agent: KMail/1.5.2
Cc: linux-hams@vger.kernel.org
References: <3F221B53.7000504@privacy.net>
In-Reply-To: <3F221B53.7000504@privacy.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307261646.56309.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

integer space should use:

On Sat, 26 Jul 2003 16:10, Hans-Joachim Hetscher wrote:
+#define SIXP_TXDELAY                   0.25*HZ /* in 1 s */

HZ/4

+#define SIXP_SLOTTIME                  0.1*HZ  /* in 1 s */

HZ/10

+#define SIXP_INIT_RESYNC_TIMEOUT       1.5*HZ  /* in 1 s */

HZ*3/2

no?

Con


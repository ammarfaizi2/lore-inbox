Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbRAKE6k>; Wed, 10 Jan 2001 23:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130164AbRAKE6a>; Wed, 10 Jan 2001 23:58:30 -0500
Received: from cx879306-a.pv1.ca.home.com ([24.5.157.48]:40185 "EHLO
	siamese.dhis.twinsun.com") by vger.kernel.org with ESMTP
	id <S129631AbRAKE6M>; Wed, 10 Jan 2001 23:58:12 -0500
From: junio@siamese.dhis.twinsun.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Floating point broken between 2.4.0-ac4 and -ac5?
Date: 10 Jan 2001 20:58:00 -0800
Message-ID: <7vvgrmwuqv.fsf@siamese.dhis.twinsun.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A Duron box running 2.4.0-ac5 (and -ac6) shows NaN in many
places (such as df output showing usage "nan%").  Right now I
reverted back to 2.4.0-ac4 which does not show the problem.
The kernel was compiled with CONFIG_MK7 and without
MATH_EMULATION, if that makes any difference.
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

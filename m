Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932672AbWEXKoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbWEXKoS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 06:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932674AbWEXKoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 06:44:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:58628 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932672AbWEXKoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 06:44:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RhkHlk6bfUaYVZ/kqhmIFtRkK6bWKI3PitV0R0ss+tE5VCxu4TM+YZqG8GChyfSb5b2TN/BnoZNJ70lxJyjWd6bRe7vO4Xf546aFahNT8rhLRE/V6RcRfL8iGO+sKbtyZhDU5L9s2stOBFwJh242lwz2/Vrlshal38AMiSrJ2W8=
Message-ID: <3420082f0605240344s61156345h22ca952b76533ec6@mail.gmail.com>
Date: Wed, 24 May 2006 16:44:15 +0600
From: "Irfan Habib" <irfan.habib@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: High speed method to determine bandwidth
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm building an application which requires me to determine the
bandwitth between two nodes.
Now I'm using the formulat BW = (max segment size/rtt) * 1/sqrt(packet loss)
But this requires me to determine the packet loss and the RTT, and to
do that I use ping. Now ping really slows down the entire calculation.
Is there a more faster way to determine the bandwidth between nodes??

Regards
Irfan

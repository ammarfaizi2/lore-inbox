Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbTHZQC4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 12:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbTHZQC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 12:02:56 -0400
Received: from mail.zmailer.org ([62.240.94.4]:32423 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S262740AbTHZQCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 12:02:55 -0400
Date: Tue, 26 Aug 2003 19:02:52 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: osirusoft.com DNS BLs are broken ...
Message-ID: <20030826160252.GF16395@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yielding SERVFAIL for query:

  dig any 212.78.72.67.spews.relays.osirusoft.com. 


That in itself should not be any difficulty, but MANY
filter codes in different MTAs appear to treat that as
if there is genuine registered rejection!

I have seen this at sendmails (up to and including lattest),
and at Postfix!   But also at several systems not willing
to tell what they are running do exhibit this very same
misbehaviour.

Lots of bounces will result in lots of people getting
unsubscribed..


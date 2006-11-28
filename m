Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757453AbWK1WF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757453AbWK1WF4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 17:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757459AbWK1WF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 17:05:56 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:42658 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1757453AbWK1WFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 17:05:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZrjCNF/B40hAf/xFgcjiW9tA65a1es6SpfIEdeJ5ARcSpIFBlU/ZwlBVpxQcTGHZ2NTdSAqLrLeoD9jUnXk290SY8rgMEG6h11XcDWKEmMHGTob0UGmJ4g4j1THWL9uTpckSNHByWpOB+tP3oy/9qidJZfacyuEoJKUP32wwg24=
Message-ID: <bdd6985b0611281405j3e731e3xc7973c0365428663@mail.gmail.com>
Date: Tue, 28 Nov 2006 16:05:54 -0600
From: "Matt Garman" <matthew.garman@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: What happened to CONFIG_TCP_NAGLE_OFF?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to globally disable nagling on my (2.6.9) system.  There
are several references on the web to the CONFIG_TCP_NAGLE_OFF kernel
config option.  However, it appears as though this no longer exists.

How might I achieve having TCP_NODELAY effectively set for all sockets
(by default)?  Is there a new/different kernel config option, a patch,
a sysctl or proc setting?  Or can I "fake" this behavior by, e.g.
setting a send buffer sufficiently small?

Thank you,
Matt

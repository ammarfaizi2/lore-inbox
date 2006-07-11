Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWGKS3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWGKS3q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWGKS3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:29:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3501 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751179AbWGKS3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:29:46 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>
Date: Tue, 11 Jul 2006 20:29:36 +0200
Message-Id: <20060711182936.31293.58306.sendpatchset@lappy>
Subject: [PATCH 0/2] mm: measuring resource demand
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This patch set implements a refault histogram. This can be used to
effectively measure resource demand, as outlined in Rik's OLS paper

  "Measuring Resource Demand on Linux"

available at: http://people.redhat.com/~riel/riel-OLS2006.pdf

This current posting is meant to start a discussion on the topic, with
the ultimate goal of getting something like this in mainline.

Peter

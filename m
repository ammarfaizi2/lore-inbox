Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269542AbTGOS73 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269595AbTGOS72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:59:28 -0400
Received: from [66.62.77.7] ([66.62.77.7]:10885 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S269542AbTGOS7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:59:21 -0400
Subject: Re: 2.6.0-test1: Synaptics driver makes touchpad unusable
From: Dax Kelson <dax@gurulabs.com>
To: Ricardo Galli <gallir@uib.es>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200307151244.53276.gallir@uib.es>
References: <200307151244.53276.gallir@uib.es>
Content-Type: text/plain
Message-Id: <1058296451.2394.63.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 15 Jul 2003 13:14:11 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-15 at 04:44, Ricardo Galli wrote:
> The new synaptics driver doesn't work with Dell Latitude Touchpad, it doesn't 
> work any /dev/input/event?|mouse? and /dev/psaux neither (altough the same 
> configuration worked at least until 2.5.70).

I can replicate this problem with 2.6.0-test1 on a Dell Inspiron 4150
laptop as well.

Synaptics Touchpad, model: 1
 Firware: 5.9
 180 degree mounted touchpad
 Sensor: 27
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
input: Synaptics Synaptics TouchPad on isa0060/serio1

Dax Kelson


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbWCULDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbWCULDB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbWCULDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:03:00 -0500
Received: from pproxy.gmail.com ([64.233.166.178]:21098 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965027AbWCULDA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:03:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=F1R72B2jkC7TMt3Hnods6qHbWLWfNQpDP7g63ahpQFs6NNe1lC00ht21RFmK18r06xPTWrfyutQfwWpTVu/oflPbMiP6FMUcv0Yp21dGUmxx+oIN5i2Rf4/vKfxfwpOASNWZ42o9PmRuNnEYB5PwwaVidSSxkmV1YA98xFXsN7E=
Message-ID: <48a4d13c0603210302h3eb23f12v1bdf3c51c8f9b711@mail.gmail.com>
Date: Tue, 21 Mar 2006 16:32:59 +0530
From: "Anand SVR" <anand.svr@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Accessing kernel information from a module
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am in the process of writing a module that collects kernel
information of various kernel subsytems and pass this on to a remote
monitoring/management node. The information could be statistical data
maintained in data structures of memory, process, network and so on. 
Or it could be any kernel variables that are of interest.

Can you let me know to what extent I can realise my goal ? I have hit
the stumbling block already because  the scope of information that is
accessible from the module is restricted only to the exported symbols.

Is there a way of accessing proc information from the module ?

Any input from you would be of great help to my project.

Regards
Anand

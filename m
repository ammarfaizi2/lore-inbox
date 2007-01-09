Return-Path: <linux-kernel-owner+w=401wt.eu-S1750749AbXAIE3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbXAIE3L (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 23:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbXAIE3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 23:29:11 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:65033 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbXAIE3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 23:29:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nwzaQOMWKvIaJef+weSId5cBMgaJeIbJr54qVAnteN9yQKgHnU1zPQU9AtcjWQ6tlo8pvO3sz5nZNdEVf8L1/WeTHZH68pCATh8TDDrLbpY0uRfcZFFIKH6Fpl74iblSiCSv71/QIJRvLml0cRTEp+bVPKIvge8JuVh3ZkUEQ/Y=
Message-ID: <7c737f300701082029i1ce9f7d8oc67cb3339c9c2856@mail.gmail.com>
Date: Mon, 8 Jan 2007 20:29:09 -0800
From: "Alexy Khrabrov" <deliverable@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: installing only the newly (re)built modules
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.6 build system compiles only those modules whose config
changed.  However, the install still installs all modules.

Is there a way to entice make modules_install to install only those
new modules we've actually just changed/built?

Cheers,
Alexy

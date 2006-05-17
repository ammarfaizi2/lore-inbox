Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbWEQMu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbWEQMu3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 08:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbWEQMu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 08:50:29 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:18702 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932547AbWEQMu3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 08:50:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ibUgwiNUykAyTx1jeFr48zSllNwE7l2rz0kNKUTKNj7P1n+b0g+ioJpzftwRap+qlIAcDMfqJm6VlDrd5xrqIaeEBxE1juZdRFBMlxZSjpTfdDE0PmW8hET/4d/pCL7GWVV3bQZazm2cSQ3iT/0Kks3flGv9a8GL4HtZjGlIKZc=
Message-ID: <8bf247760605170550v1ff7562aqdfce165daaeb0f02@mail.gmail.com>
Date: Wed, 17 May 2006 05:50:28 -0700
From: Ram <vshrirama@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: struct platform and struct device queries
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I am writing a device driver:

 In the probe function i have to give a parameter struct
platform_device * pdev.

 when is the probe function called?. It is not called at
initialisation time (module loading)


 suppose i have a situation where in i need to probe when the module
is inserted how do i do it?


 is it possible to get a struct platform * in the init function of the
driver?.


 Is there any call to get a struct platform * ?


 Also i want to know if it is possible to get a struct device * frtom
any call. i need a struct device * call some functions.

 How do i get it?.


 I know if the upper layer (could be kernel generic code) calls my
driver probe function - it passes a struct platform * or struct device
*.


But, is there any call to get it calling from the init function.


If so, how ?



Please advice,



Regards,
sriram

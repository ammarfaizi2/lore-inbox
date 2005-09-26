Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbVIZPW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbVIZPW2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 11:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbVIZPW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 11:22:28 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:63888 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932298AbVIZPW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 11:22:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=ZzCLmKN+iqmM27epRC8Y9Y5aEbMAb2lmnNtIlngI4WizEQk3fcv/Odwc0e+GrsstwPAJSVKZv5jnMDXgKsbnUQFxlap2JnRueMrvleL/iBqjsFKqAFu4zL8zx1yYbat/NLkPn0l2C5Z7uC47fTPwLlVXStf9bTMMkkrCXk2X7jU=
Message-ID: <4338122C.9000901@gmail.com>
Date: Mon, 26 Sep 2005 11:22:20 -0400
From: Keenan Pepper <keenanpepper@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050912)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ipw2200 only works as a module?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_IPW2200=y I get:

ipw2200: ipw-2.2-boot.fw load failed: Reason -2
ipw2200: Unable to load firmware: 0xFFFFFFFE

but with CONFIG_IPW2200=m it works fine. If it doesn't work when built into the 
kernel, why even give people the option?

BTW, a better error message than "Reason -2" would be nice. =)

Keenan Pepper

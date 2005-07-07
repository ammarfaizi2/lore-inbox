Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVGGS6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVGGS6h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 14:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVGGS43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 14:56:29 -0400
Received: from smtp3.netcabo.pt ([212.113.174.30]:26070 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261739AbVGGSyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 14:54:22 -0400
Message-ID: <26284.195.245.190.94.1120762383.squirrel@www.rncbc.org>
In-Reply-To: <24833.195.245.190.94.1120761991.squirrel@www.rncbc.org>
References: <1119299227.20873.113.camel@cmn37.stanford.edu>       
    <20050621105954.GA18765@elte.hu>       
    <1119370868.26957.9.camel@cmn37.stanford.edu>       
    <20050621164622.GA30225@elte.hu>       
    <1119375988.28018.44.camel@cmn37.stanford.edu>       
    <1120256404.22902.46.camel@cmn37.stanford.edu>       
    <20050703133738.GB14260@elte.hu>      
    <1120428465.21398.2.camel@cmn37.stanford.edu>
    <24833.195.245.190.94.1120761991.squirrel@www.rncbc.org>
Date: Thu, 7 Jul 2005 19:53:03 +0100 (WEST)
Subject: realtime-preempt-2.6.12-final-V0.7.51-11 glitches [2]
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050707195303_97964"
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 07 Jul 2005 18:54:20.0207 (UTC) FILETIME=[486D2BF0:01C58325]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20050707195303_97964
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 8bit

> Hi all,
>
> These are one of my latest consolidated results while using (my)
> jack_test4.2 suite, against a couple of 2.6.12 kernels patched for
> PREEMPT_RT, on my P4@2.5GHz/UP laptop.
>
> See anything funny?
>
> As it seems, the kernel latency performance is in some unfortunate
> regression, and I'm experiencing this unsatisfactory behavior ever since
> the latest RT-V0.7.50-xx patch series.
>
>   ------------------------------ ------------- -------------
>                                  RT-V0.7.51-11 RT-V0.7.49-01
>   ------------------------------ ------------- -------------
>   Total seconds ran . . . . . . :      900           900
>   Number of clients . . . . . . :       14            14
>   Ports per client  . . . . . . :        4             4
>   Frames per buffer . . . . . . :       64            64
>   Number of runs  . . . . . . . :        1             1
>   ------------------------------ ------------- -------------
>   Failure Rate  . . . . . . . . :   (    0.0 )    (    0.0)  /hour
>   XRUN Rate . . . . . . . . . . :      373.3           0.0   /hour
>   Delay Rate (>spare time)  . . :      220.0           0.0   /hour
>   Delay Rate (>1000 usecs)  . . :        0.0           0.0   /hour
>   Delay Maximum . . . . . . . . :     7853           295     usecs
>   Cycle Maximum . . . . . . . . :      852           943     usecs
>   Average DSP Load. . . . . . . :       41.8          44.4   %
>   Average CPU System Load . . . :        6.8          16.3   %
>   Average CPU User Load . . . . :       28.8          30.1   %
>   Average CPU Nice Load . . . . :        0.0           0.0   %
>   Average CPU I/O Wait Load . . :        0.0           0.1   %
>   Average CPU IRQ Load  . . . . :        0.0           0.0   %
>   Average CPU Soft-IRQ Load . . :        0.0           0.0   %
>   Average Interrupt Rate  . . . :     1679.3        1680.4   /sec
>   Average Context-Switch Rate . :    12508.6       14463.2   /sec
>   ------------------------------ ------------- -------------
>
> JFYI respective kernel configs are also attached.
>

Sorry, my last post failed on packing those configs away. Here it goes
again, hopefully.

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
------=_20050707195303_97964
Content-Type: application/x-gzip-compressed;
      name="config-2.6.12-RT-V0.7.49-01.0.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config-2.6.12-RT-V0.7.49-01.0.gz"

H4sICL95zUIAA2NvbmZpZy0yLjYuMTItUlQtVjAuNy40OS0wMS4wAIw8SXPbuNL3+RWsN4cvqUpi
LV7kqfIBAkEJEUHCAKglF5ZsM7a+yJKflpn4378GF4kLQM/BttTd2BqN3tDwn3/86aDjYfu6PKwe
l+v1u/OcbJLd8pA8Oa/LX4nzuN38XD3/5TxtN/93cJKn1QFa+KvN8bfzK9ltkrXzd7Lbr7abv5ze
t+tv3d5Xob5OO99uvl3efu10v3WAXB43znf46d46vc5fl4O/rgbwoXP1x59/4DDw6CieD67v3osv
jEXnLxF1uyXciAREUBxTiWKXIQMiZIgDGPr+08HbpwSWcTjuVod3Z538DdPdvh1gtvvz2GTOoSUj
gUL+uT/sExTEOGSc+uQMHopwQoI4DGLJ+Bnsh3gST4gISKkLGlAVk2AaIwEUlFF11+9lExulTF47
++RwfDtPBbpB/pQIScPg7j//KcByhkpjyYWcUo4BAAvMQDyUdB6z+4hExFntnc32oLs+EwylG3MR
YiJljDBWZaJzt1j55V5R5FIT5ThU3I9GZdJJOPxOsIojMgU+GtrQSfahxJ1JMXmYV7kvwobEdYlr
6GWCfF8umKwMncNi+NvSBLZZCRRzJOV5DlzQQE1KuxuVJjhEksRe5Jd21IsUmZ+/Eh6WsXLMCCtJ
EIYp0VEArQKsYEflXaeB89GQ+EZEGHIT/HvEUvhp/YoGi2xow+rTNUgGPIAmqeT52+XT8mENx2L7
dIQ/++Pb23Z3OMsgC93IJyUmZYA4CvwQuWXO5wgvFLhAG6YQDmXoE0U0OUeC1XrIpV0axTYfQQqc
k9k2GQiLM89328dkv9/unMP7W+IsN0/Oz0SrgGRf0Tdx9QhpCPFRYJyHRk7DBRoRYcUHEUP3VqyM
GKsepgp6SEegT+xjUzkzc0hjc9WHBB5baYi86XQ6Zib3B9dmxKUNcdWCUBJbcYzNzbhrW4cc1AmN
GKUfoNvxpqNR4C4rAjmxzGNyY4EPzHAsIhmadTEjnkcxCc2ixmY0wGPQ75aJ5OheK7bvmtEjErpk
NO9a5rwQdG5l5ZQi3I97Bk6WZPCsNTQQMz7H41EVOEeuW4X43RgjPIZzPqaeurupm3SwiXQoEKgQ
F07ootp4xuNZKCYyDidVBA2mPq+NPaxa0lQLhBy5jcajMHRjxOsLAmtB/DiSROCQ1yYC0JiDLYth
JXgC570sV2NOFGhqZtEftrPPBSGMqzgIA7MsFQTT0I/AfxGLViqXyIkKuWELCwqhysYxhTUAsQw9
RcW9bGLGSLhmjMBREziclKynmEnCTnsuOQ20U3XGI8lioEB8HIqyeUp5zw2bBUAaNsGpj2Xa29AA
BGVWNxIMm7dChSC+Q2TE0cHEqpkFGYah8ug84hYjSDF4SHBwrV0waTdLmIMHXcamRtJb7V7/We4S
x92ttP+eecu5V+OazHgQjukod3DOYp2BLkfG4XPstQXNkBqDsxf5SDtHJg2thKg4hh41UI3RVCsG
HFfFRZBR3duQBGt/vsEMvv0n2UGYsFk+J6/J5lCECM4nhDn94iDOPp9dB17pkzMYG9xG87GGgzJD
AhRbJMHaNLdB9w+jPP293DxCwIXTWOsI0RcMn3ou2dTo5pDsfi4fk88QStXcNd1F6ZDAt1jLUw2k
FZeAYwe/Kx6+xkmfEJNOSJEI371WO0cKOlnUoZFSELJUgVPqkrAG81CdKg9LQlGDqzER4LgCtDpd
BMw0cjtb6JDZkYYjWlmEj/DEp1LFC4JE2cdO0Y19rjJA1lhOcA3Aw1nK/QoM1zcPwjBVPWSplWIt
1iNtB58VokGVJBMyzkoylkkUOwn7Z2dIQ1mSq3O3nDX6Am3ieLvkv8dk8/ju7B+X69XmudwICGJP
kPtGy+Fxfz5XsOwvDscMU/TFIRDLf3EYhl/wqXzSUuacjxqmYJfT2RqNXIpmLPvaQgIWihgj4AyN
gpJh1yA9YhWS9VCFFQPXZgwholBDi8Sm7aTZ39I4n4wQXqQnxEoTIEbsvdtkNk+faItXisglqqhb
+G5xFM1wiX/3qjFGpl4xhCau3nS93xd4uXsCYfjcjDwzwvKBz5pYV5Ghz3pDN88OYj7w10cYzHnY
rZ6ey9HfQud6KuO41ze9W4vp7nVuzd42oPrXV2ZnAFNsnbDe0CEpi4+euHbypAJbqDVuPn/qjLeH
t/Xx2XQ+8zSM3ucGz8nv5PF4SOP8nyv9a7t7XR5KLBjSwGMKIl6vlPDIYCiMVAPIaOoJpZ27yd+r
x7LrcE5prR5zsBPW02ywtsBFPniyFUdQ54tijwqWGsphRP1KjsGbxTqvYNF8qWDErqBTg95jyet2
9+6o5PFls11vn9/ziYP+Ycr9XGYlfG+K7XK3XK+TtaP5bhBWJPTRPgtfDtBphbJk5VAIGSgypS7O
zYALXlhRH2eUjHSOMjSf8zNZJl+tVCNLeF7gu73BZZMXWgRTf2S9fC/x4tw6aLpVw/X28ZfzlPG8
JHn+BPZtGnuVfS6gc3PkCrOjFgdYt8T8PnbN6y7QmErZRqMHdxG+vTYnSQqSqJZnaxDgcKazxszo
0RZEOrlXlpJTY7HgKtTY1jGCoZlLBV7OzVmJ0yKGLXMTiJ2FugSEVUGIede9NuEk/UHuLju3J6TO
fQPCk+AERwITnc0+zcMfmiIM7IqQxXyisDt1S0q9DAYF4XlEyLtByeWoEMzSVEJDGOHsyMeXRKc8
dyVhBNMO1Fr3hqW8QAFFsglzCXJ9WlZiBQZ79xXfWqE4BL0UEzVuTAeQF/DD6QXz2IXw/aaCAXkv
aeGc1xkwP5PJcp9Al6CJt49H7culccPF6in5dvh90DrfeUnWbxerzc+tAwGFPkFPWjtXwr1S17GE
ObVKztiNa+ew2YtLZSkOywExxHmK6oQuMR17oMKyvVts1BeAADbaNUNO4/kh5+bkSIlKYoszpnmj
EKyChlj5TeECljy+rN4AUOzjxcPx+efqd5XVups8wdGuQ5h7fdlpZ0clcsi+x3KsbSgV9yZOhZ43
DLUj1jbyv5ldyBW97plziCed8KNbSzcb5AT8z5qLX8OmNwsmVXFuHaNIVYxmjgoDf6HlrnWWiODr
3nzeMk3k0+7VvF8eYObiAtzeOXNvLufmfPeJRlE6b9f1qSy096IE9XzSToMXgx6+vm2fMpZXV712
+6dJ+u0kY676H8xYk1ybE9wnG4a7PcuFRUHCgXntdlIObi67Zg/91ImLex0Qgjj024/GiTAgs/aZ
T2cTc0R2oqCUoVG70pIUON1t3y/p49sO+YCRSrDebTsjpxSBdMwtwqq1FhJmr0fj9IWDJOoD9Z1d
1tePKZ2aXJEcWT/aZyPU0MCp5s5czaYl1cjSLS18S0Pq2DtFimnzvF12bfjpabX/9cU5LN+SLw52
v4KL8bnpw8qKTcJjkUHN93wFOpQWglOv5mDn1P2oufzta1LmAYQ4ybfnbzBx5/+Pv5KH7e9TuO28
HteH1RvEhH4U7KtMyo00IGrswmloGqjKxXuK8cPRiAaGGenJqN1ys08HRYfDbvVwPCT1EaXO6Ckl
mj17OENYUg1AQdPfDaLz+OvtP1+zoo+nZpq74HZ/FoPkz8GNpWYFkI4CVLe2A5IS6OtVD9m2Npsp
tpnfDD1G3ateyxApwaU5F5ERIFxfRQVN8Q2soZRwzADaxsgYAkzNDwq+eu+qXycRBI54dv8WM3l3
1enUKbJYnARoWK6XqWIZ+FB3jZaCpJkApRZZQUZDFApCm4o+Ed227ZDLVUx75hg6k6egZ70jJyOk
WauVP/hI7TRZ2s4+jtXLTrHDSMKhsvhg2ULYvN+97bbwwlW43xuYl5ISkNYpeJGKwJF0Q4aoea0p
2chV5oKDDJvf5AVYXPXb5lIjjBmzJDqyTbLckuU7SFVr44CirmWLM7vAW9hCmdkIpsh09viyc93S
gVwwoBmAJLccYsotd8Tp/JDsms19hpa0d9kxxzApwX0qWjEoqo9pWiQwJ+nWZKxKgnqZsqk3Rb1u
2zHVBL2PCPptm5gS9FpYDATX/W4Lgc/bVp9t42XbRri4f3v1ux3faTEVClhrx0bdy7h/6bUQ+Eog
qcIWSQok77dwoJFyzzPSaX4xNa7Lp+XbIdkZs4FZmrvNoOUkXouOyUkCGnxHsTU0z6nu7Tozp8h2
7cpwQRGun3IXr/ATnE+aQI/5JSUFh7SSL8Y6Y2TKGGSJZ+1hfa16o86n1DLrHKo/LbuSzJjWYCYj
fkpTsnLu0GVZ2tCcIGexDBCX49CKZ1QIi6AA9gcRZn2qW2pvkSNDess76opgh8GsGk75qQcvkrV7
/yyZQghxuv3bS+eTt9olM/gx3BVpKk1U3JXI48P+fX9IXksXD+dgIyeOp0QMQ0nsN/YnyjCCMzBs
p8kqSnMoSE/TC23clDQ74Zj6i8CUgzjPZYxpea18tz1sH7frUr+Nheqr97xNc0w5tNSPnZemxukW
tMzKneb91xECzWhoHBcbii+0R2aXkZq/lqKC5PDPdvdrtXluikVAVBHTlcgaJd8c4QlR1bsWDQHf
A5lKIaKAViwZDBNPyMLEnqDaL+XZMcFIGsuieYzcKQowcUGColp5RtGY+zr9CH612WoDWdrWfCCb
ZPkpsBHV7nIqi6actiFHwtwrEtzirS50jX04obal6X6RZT0aR6R5PjSbUL3ep4pXURAQ38YHhblL
kUVPnNDwcWp2BKwIGNqjvjJcWUqseK0K6FP5eULFCMEcUnojw5XllkpQ15J4mvooiAedXtdcxOwS
DPM2onwfW9QJNxt/CD58S0Fcz5yt8xE3K2O9ja6+/jVPjcBfy6xnsNzsyDW24X4rtaW+2O6cn8vV
zvnvMTkmtUIXPXB672OdFvZlNoBNgzmHZH8wdMsnqhZjnpH5i4MyvQbFwszpAg2GyqTX0tE0Hr4r
AR+q+meMmECuJaCiwnabalJ0MFKWXKgketyIMcutTBi4tbzSeVPvI+TTH5aaADjUDYYjgTfJoXQX
XdJMdbHO6icOL/pxE7ht3Y4DYgBBI3tYHT5XLI22kvrJT6laglFaZSDnC0aQWcfIKBhZbpN171MS
uKGI+6DDLGcisJSillpLZnaKSyQCYdS801LH9eoNxP91tX53NrnA2g11pk59i3VAqntjidj0zZVZ
jsbcFqqnul2a6vhSga6XjQHQEuog5g663W79ivaMdxFXBOvaFeFRm3HDfdtNBeKCYovrPby8NMKz
Sy/bjLAc3P62cHJkSZYSwkVo4yWxITwQW6NfGiAlCaNlDy8gvUm9DumEHIDvh81yoVEqtCRsqLy1
zZlTbE3jRIFrPRjK9sBnCgGiGFNLlX2mJrWD2KooYEaFkigJBwkscanr98xGkNTvTs8TkYP+wHJD
B8oa4bF5CxbE98OZZwm0xaB7bS5+k5PbgW9ppVk2JX6IqTKrcEVHYWC5wArmvQ9YaeAlnY/MToDs
0WaYoLa/ko0jtP9v0PuqafV1pLlO9ntHC8mnzXbz9WX5uls+rbY1tZ/axCLMCB/223VySM7Ndc3h
/hz3v+2Sr+BWfet2K4uRStiUpbBJ6QxNrU/U8izHvyCBJWgq+/qz2ZbqfMfbtzfNx8rKDAkfgRa4
GQTX+n3QVb4XWllYu0PUknTQJeGWSAE8XtK0Yo2x+ePr42qZFqE+HPftU4ixrbA2Y7Xfv+p0G0Py
3Wr/6ozUhXtMDiAX2ciflhcPF8+fdU3naXATIwWV7MoUd2vBm4EJgiCwVOCapuOs1rliFNNS2ffG
Kvr4amA+/GeCG7OlKnJ4bPq9O2hN83Fr7FDIJMMfSC04MrddbKnEzWnmVOCe5X6gyEnOTe7ebLlx
VsUji4qemFlm5bmuWdWOKeeWTGXNOyrAvFIKCF+zOB707sRMHmfRY6mMFmAIQmlc70jDYqVMiQqN
1nVRSJF6q6F0rXEz4C3PGqXN+dPiZ0ung4NcdePPbeCTfjhcJL2odAMQ7TzLVzELGtPQ/nDs3162
m3dT5TQf197TZSNs3o4H6yGiAY9OuaVon+zWOpdbEZoyZczCSCcap+V/B1CGx1yiaG7FSiwICeL5
XbfTu2ynWdzdXJfKITOi7+ECSCypD02gZA1fwZKpnvprvRGZmm4FMsY1cp2VlhOySKvPzgsuIKC5
J8NKEvyEAV9uYil1PdH4kw9J5upDkoDMlLFit8Ty8ov49LGn7FXfsmtgs867RgAdhpZkRUagLzIs
j5jycXG32+HI8sQ3JZnK+XyOLG8RC/mQimKzA5pLSBjhcSZjLVT6YUBDIsZg4dLnhfQiTOvny2Uf
upC9VF+iv8Z00LmscDMDw28rtzIKrAY9fNO1xAIpCUfCtv85Aaawl4bNz9A+Hda2OoMLZK4DGyFG
6rPOtM/Lcrd81HdmjaL4aSmHMFVxoftOsPGsBKvMA/n5wxEIe4ShMCrZrZbl+pdq00HvqlPdixzY
MlyGtlwgl0jSx41mphYkgYgjJJS8uzR3QeaKBLV/BZJl0MA71xQASddnfqORd4VDQRqL1MCWRX6X
pv8ZoO8BbgcxV4tSZXjxSssCzOvme1en2vi0yIWIsnr1eTEXi9W1KXOd72+GMpQzWk0VMwoBYuD6
hmznbHl4fHnaPjvaLy2JyAwpPHbDyou2AgYyN0OLMDK5Unlv9rsv/Sz21JMlpXIfga8bz1zz2U/v
TBTBYzuFT1n3qn/VSgB6o2slkPiq17FiSSTC1gnQ4U3H3nyGPCLsbXWJCDhAlnnpwlhr2+sOtLUh
MY/sHJkN+te9m7HXRjC4ubHjdf7hRx2bO2/o68Nynzw1ha3koLeKBKNzcEpnZj1uGhO0+r8Yk34w
LPRsel8XyeGHnQPNB52DVhdwKC353WAqkEkJCVV6WQxfIOSQKhzpdzuVSgKdsDKnyH3OFbFUKrrK
cjUj+rfX5jgQcQhtbFlqGQYL3mSgl1XWHl4S5+d6+/b2npbaFt53Zq4qxQLWVx5oZA47XNF8vpwH
zI8GQ3yeMMRMOvaymThWT56cOYRmhreI593mlhgYFPMo/achzTfeWSzDmTGFheHH8Eab9rAhfOlV
gkP4GmP93zqqZuXUHq2ft7vV4eW1WrTQ008f9Btsi97K8Ryba5POeGQc9eQ2Ds3Zkaw91Xq9pf//
NXYlzW3rSPg+v0I1c3inVxG1UjMncJMQcXsEKcu5qBRbk6ieY7kku6by76cbICWARFM+JGWhP6xs
NLZegD6zXzte6YTphqQnwXxKPOgqMr4YkPQwDteU3hXSYaNLZ+YusZFFIlo72OefzErYaiMtlU8K
xBMtlszoXbZGh43wctWDKjLBNpRZAyIU2d4HZTsOCz+hc4PZ0SJiQX95oM8I05SavJgRFg5ILiu6
6g1hVFvTcuK6UpKzLMgymt9gLrQ/nnmEEofXy+l8gdPD8Y2aFCKEvSOh7CdJArZMiTMkrLZMjH2E
TQyh+qhjxnfqEh75hFNDAuFQdmYNJMIn+P6OAyQnXEY0kGU8dVxBrF83zGh4B8NL1+4mrAHECSGZ
boB5//AD4F4Vc0Jz9AqglLFvgHuNdO818u44EBZJGoBQTq0BCds6M4d4taoxue/Ox4Q9d4MRifAn
c2+86G9wn+wxi0r6GRakxcyldMRrDOyz5y6l3n/DxHN3WvYzdrOl70iXDN/a5JpLiRVtEo7H/YMj
35f7ZwbsCFzqGcHALPqHD7a77pTYhqIgVGYmeLa/A8FtyB0I5bVFq2fFuwqNwf7lZX/54zJw/vzf
EeT39w/zQaH7YpQcL0+2DR73EvR61sWjfvGvw/Nxb7lIQsXPnbq8leDN8flwGkSns3La+49/6clM
6XAbtaoSvNKd2OWIoueJfXDq3A9/+czOEQrg36PnxIqryIKx6WhCTCMdYhcQZZXC6Xs8HNuXsbqA
Et95+3oJVcydsZ0ZFSLZ2vcU9VfK7a8iiroKt7xKdlnBCU+RBmwZJjy1vzvVI7p1je9pELMNfA7k
5oZrCnz2trKHfPze+SwgDjOKXsDgEZfLOsAu4xWCfcP7lR4AdLkM++pQAFIvRYFgIeG0kluDgdMy
scdTCBE5syjpq0chir4el2GBXi7tTFFDioo4t9f0x3yVEfyiEN+yuCxMu2klto4/ju/7l1oweOfT
/vlpL9UTG7c5OhcEpt2uJC3P+7efxyfryS3qmwcCDk2+5br89IqqFYPn4+UN3c6oS4Hu0XazZLaL
3CRgtjvVpgOoeahlq81oP16ftevjrEqDZkZcHagp3+cSOmDnp5/H98MTehfW8qWa+xL4oY71ZlLu
J2bC6iEIczOpYA8JD7iZKMK/qjD12+VBsuqTmZwJgR4WtdtvSEz4FsQfkDpN6iZeq5MkoxhYi5uO
3dZpSK/Vy2vn2vblPA0IC6PGi1RnYZMNz6vJ0JFPBmYrLT3f8KI7eEmZs027g/K+v3Jm0+mwhZbV
3R6gmfW6CIAscKjVEsm+mIyo01BDJna7DZk4bwE5hEOSS9cNZJcypgPyshJ+zITgxPu8gqChS5gQ
z/4KAmKUJMvXDvLWzEDAqkuoeCEz5yVfjLb3hruB3Rl2CRvTrRYeXQWcXekvIjz2QHcVexkVWUo8
OuAHT7g7Ji4yVMPjsWA0w4gli9mWsD9GuvBbd6nNfbl91jF/Md+h/1nfnB4s5tPJ1GlP/x6fJjey
dAREHBkQVLnUVVhDJrQgG3LP+MHGYjymzCuBDlvfOc0WwFWzngmFTOfSTAfC2Bmu79J7ymdDZ0jz
3jorls6IMm1Vsp9RD+pATpMRcfkpJX4S9ggqoC568y5mUzr3KiAseeQCit7feqbMYxJRuzzFqWJC
qdTWM64vO5w9nfGczq7oPR9VOItxr4hezGhyvfkkrmQAECXUnbIUrX7ozHsYQtJHxMm8Fs2xu6V7
3wDo2SyylPsb7hGam2q1Zi5p9H2j3xEbm+2IMvuWHMZUYzuirxKeXfQBQUZByUzJh8mV2I4eb546
5bsSsT3YbLvK423AZEKPcB7INviWa5y3w2u9FRUdvTi5fcVdWNIV9tjjzkZa9rbwV7sVE7uVr+lq
GRQ0RzVI+gqASPvODm85Di8v+9fD6eMiG9Axy1SZN8CSkWEmhOkeS4MHTnmckDkfU5ZwH0RcmhGW
EAiz+OI26FnZbTu2dnW6vOOZ5P18enmBc0hH0Q0zhzA2cuhaQyLTRR5zNFyxHySvsCLLyt2q8nal
zZBKNpGoRaZ7HL2wBJzZ1NmuKGhJGYc10PzQFVG6iF3HQYJ1eGp1D/9lf7nY3O1cpxLZeS+uwhL6
vmprrBoo3NQTHWN+0m5zrWrTaXGaleG/B7JXZVbgo9XhFb3lXmqjf9Tt/EM5VDpe/m6myh+DX3AO
3b9cToPvh8Hr4fB8eP7PAD0w6iWtDi9v0vnir9P5MEDni+h7FzjdZJUa3hllldzjVd5AsZJFzL5l
1nFREYbUC72O4yKgbJmMakHg3QXB38wu83SUCIJiaL+ma8Om9vt3HSajI7WcHVxZVNdTbc3bFdeO
7HVCo/F7rQjSdpH9ZbvOYntOl7KDBwPvBKlX031ihlCKipLzUbWTpDKet27DNOIDg4/f5rS1V/Zw
jvRWn7CSrjGRCqK0LJPHEJK8pTRYZWdKEINhkllsZ+WH/LX/Qdj1yIYFvtvDxDKeRmusrkVb79bN
ZYZ5CKRKh9WLuNmWmYVnf61EIveSvrxr3EaxB/tJXQr2zZTQTJBTJJwQ20RJTRe+M7RvntQE28ys
zn4key1gA+tHHeH70NUMxqFrzJ9t18uYz2cl3ck1HK57NgE5sB0VIALpRQmr2JRmDvhHmaog+Vvg
jMxRNCZo2mwIsZtSJ5WY55UQc/MEe81Wa+zCTgMyvtsuPNXXxGsrU2bVV1m3UEyt7y+pjBedLaEN
54XxmrD801APK16Gq7BPzitgwJfoAM8P445utA3u5yOnj1tr1GNeYETDxH560pBhAoxxDxSVAWzS
enYoNW7DKWULDcRzIhqcjrlbShgsPzVeDW5X2o+xOnuwIrn/YXluV27XIOvwUeQsxePJJ6F3YTHh
5EnHZB6P0fHFPWCC4ShbF6tdVB6PxsNxZxOmiKuc8GOrYQSL7s6l+x/Ff/TC4iv1ZKYB0cStbx+n
UHi3SbwC6agk5TZrOLkOGqc1QoqFCZ/RSwZQCT0hdRYIC/HACI+OUlTzbNqzjMfhMitxk0IjfLrw
mHDcIdefRxl7iF5jVuhEpVwTWpAaBAZ6Q4sTHvRv6QSHlczbLOnp1dbivX4+ViZfAhFrH+5KWu6f
fxzebWZxWOKSYbu7h/fE/yICqeNsiRiaGLql8JOM2II0qZl8W7kw6cET14c2/vrf4+vRwxOYTdsN
/k85XgZ02hhhoBNlHmhE9y1HO/M6oU7abdF1rKWRQB+rLGaCytAqSRJU/F3m2w2/GpQI/argVmvM
r6YFHPwkhxAKSjwZ5EDPUYQcmC1CdTdrG752SHLMtpBmGeUtXRCqGWwpYpEldM6/qqy0+ewI4DDO
Iy3okqg8WYoR+qsqM7poRZ3Yeqgc+30JNoFkkA5/wFq+mM2GqrpmsLKYm268vgHMLLyZM0FkZMXf
aXy10A4y8SVi5Ze0tNcONCN7IiCHkbJpQ/B3EEasikv5KpPjJYI7G9roPEMlbwF9+efxcnLd6eJP
Z6oF4khLO1vkl8PH80mGDuo0+eY6W09Yt4ysHoU55+BkTH8+IOal6JuSZZKb5cmELvx2Vq9AjMUe
UWFN3eUtdeWGjTFwSfMJzZXQHJIbAwY9zBnRtFUvKY8rkuyFdFaPJvXk8mW3raRNj0BY5T1TPt1O
aCoGMqdolZ0xm6OjlPWi+x1SujYgESqViUcOCacK83MyTxYwmhXs021/fj9Kb2/l7zfzxiFnRYk+
jdOrn0DbqiqlxhV69YC4f4fVfxDvX3987H8curEjUVD90n40csOUFhq9kTe7yXhu+P/RaXNCXdQE
mXrONogr9THs2V3iJbEFsl8YtkDzuw2Z9TRkZj+ltkCfaS2hGt4C2V/qWqDP9JsIG9EC2W9mDdCC
0E4xQcSdS6ukT4zTglDqNBtO6BojCJZy5O2d/dLAKMYZfabZgKKZgAmf2x4s9JY4bfZqCPRwNAia
ZxrE/YGguaVB0B+4QdBTvkHQX+06DPc741hd4+iAaXss1xl3d/ZNwpVcEaVWZeRqXndh8Te9zt7E
dJFF6LGl+3S4Rp9WL4Of+6e/W64elX6cVA607Yqlhvka/Qtq6nsJQ7/rsHDKGE91YpyhsnpUh093
JvrGqgx9FbAbD10VoWGBbiwx9CS1O8OWiJh4LFDkOqR3XwF1RO9uvOEr8IGtwyrHEaFcP/pwfuIY
v7sJIf4ZLEYkz6KoD1uUKrAbtk8NWk9P0BQOgFCW1EfoQa4z76s91mxjYrCstSXNvTLS4KRLeN6W
ZGrfJPCxjyUhnEk7T5/NHpAVcR1qY92tFxjBX2PguijO7HeAaxm/tJdZsAxoC2UNWPMMkFkcE8Ft
J2tZiu3QhRGRI46aJUle+982w7YneY7Hnqte7+Hp43x8/61pHNw6Ez7aqmjO6q344TJNelDLCkK1
tQH5LGceyISS8m18ReKDP0Zy7UfBH/HGFkH0Vg6MJkoTQyPvlh3EU9XV+/bPv9/eTz+U7rZtgFRM
yk6+q33ikyxAey2T5Pj4/bw//x6cTx/vx1f9udUv/J3v81JT4YWk8ej2M+aeTNH0Db9BGs6I2l2V
nnpzYlWnNvFE0LwZp/6NNRoKpLZj8CLXYKBnGEQzfHqODyn/B0cnCXomiwAA
------=_20050707195303_97964
Content-Type: application/x-gzip-compressed;
      name="config-2.6.12-RT-V0.7.51-11.0.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config-2.6.12-RT-V0.7.51-11.0.gz"

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
AzN8oCEwiwAA
------=_20050707195303_97964--


